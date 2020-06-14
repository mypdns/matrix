#!/usr/bin/env python3
"""
pdns.py: Manage PowerDNS Zones/Records

Inspired by https://github.com/mrlesmithjr/python-powerdns-management

Changes:

    * removed all the CSV stuff
    * moved output to the logging module
    * Updated to the API V1 (https://doc.powerdns.com/md/httpapi/api_spec/)

"""

import os
import argparse
import json
import requests
import logging

__author__ = "Pietro Bertera"
__email___ = "pietro@bertera.it"
__maintainer__ = "Pietro Bertera"
__status__ = "Development"

logger = logging.getLogger("pdns")
handler = logging.StreamHandler()
formatter = logging.Formatter(
        '%(asctime)s %(name)-12s %(levelname)-8s %(message)s')
handler.setFormatter(formatter)
logger.addHandler(handler)
logger.setLevel(logging.INFO)


class PDNSControl(object):
    """
    Main execution
    """

    def __init__(self):
        self.read_cli_args()
        self.setup_api_call()
        self.decide_action()

    def add_record(self):
        """
        Add new DNS records

        Create new DNS records of different types
        """
        if self.args.name.endswith('.'):
            name = self.args.name
        else:
            name = self.args.name + '.' + self.args.zone
        records = []
        for content in self.args.content:
            records.append({
                            "content": content,
                            "disabled": self.args.disabled,
                            "name": name,
                            "set-ptr": self.args.setPTR,
                            "type": self.args.recordType,
                            "priority": self.args.priority
                    })
        payload = {
            "rrsets": [
                {
                    "name": name,
                    "type": self.args.recordType,
                    "changetype": "REPLACE",
                    "ttl": self.args.ttl,
                    "records": records,
                }
            ]
        }

        logger.debug("sending GET request to %s" % self.uri)
        zone_check = requests.get(self.uri, headers=self.headers)
        logger.debug("returned %d %s" % (zone_check.status_code, zone_check.text))

        if 200 <= zone_check.status_code <= 300:
            logger.debug("sending PATCH request to %s" % self.uri)
            logger.debug("PATCH body: %s" % json.dumps(payload))
            dummy_r = requests.patch(self.uri, data=json.dumps(payload), headers=self.headers)
            logger.debug("returned %d %s" % (dummy_r.status_code, dummy_r.text))

            if 200 <= dummy_r.status_code <= 300:
                logger.info("DNS Record '%s' Successfully Added/Updated"
                   % (name))
            else:
                logger.error("DNS Record not added: returned %d %s" % (dummy_r.status_code, dummy_r.text))
        else:
            logger.error("DNS Zone '%s' Does Not Exist..." % self.args.zone)

    def add_zone(self):
        """
        Add new DNS zone

        Create Master, Native or Slave zones
        """
        if self.args.zoneType == "MASTER":
            payload = {
                "name": self.args.zone,
                "kind": self.args.zoneType,
                "masters": [],
                "soa_edit_api": "INCEPTION-INCREMENT",
                "nameservers": self.args.nameserver
            }
        elif self.args.zoneType == "NATIVE":
            payload = {
                "name": self.args.zone,
                "kind": self.args.zoneType,
                "masters": [],
                "nameservers": self.args.nameserver
            }
        else:
            payload = {
                "name": self.args.zone,
                "kind": self.args.zoneType,
                "masters": self.args.master,
                "nameservers": []
            }

        zone_check_uri = ("http://%s:%s/api/v1/servers/localhost/zones/%s"
                          % (self.args.apihost, self.args.apiport, self.args.zone))
        logger.debug("sending GET request to %s" % zone_check_uri)
        zone_check = requests.get(zone_check_uri, headers=self.headers)
        logger.debug("returned %d %s" % (zone_check.status_code, zone_check.text))

        if 200 <= zone_check.status_code <= 300:
            logger.info("DNS Zone '%s' Already Exists..." % self.args.zone)
        else:
            logger.debug("sending POST request to %s" % self.uri)
            logger.debug("POST data: %s" % json.dumps(payload))
            dummy_r = requests.post(self.uri, data=json.dumps(payload), headers=self.headers)
            logger.debug("returned %d %s" % (dummy_r.status_code, dummy_r.text))
            if 200 <= dummy_r.status_code <= 300:
                logger.info("DNS Zone '%s' Successfully Added..." % self.args.zone)
            else:
                logger.error("returned %d %s" % (dummy_r.status_code, dummy_r.text))

    def decide_action(self):
        """
        Determine action

        Based on action passed determine which action to take
        """
        if self.args.action == "add_record":
            self.add_record()
        elif self.args.action == "add_zone":
            self.add_zone()
        elif self.args.action == "delete_record":
            self.delete_record()
        elif self.args.action == "delete_zone":
            self.delete_zone()
        elif self.args.action == "query_config":
            self.query_config()
        elif self.args.action == "query_stats":
            self.query_stats()
        elif self.args.action == "query_zone":
            self.query_zone()

    def delete_record(self):
        """
        Delete DNS records

        Delete DNS records of different types
        """
        payload = {
            "rrsets": [
                {
                    "name": self.args.name + '.' + self.args.zone,
                    "type": self.args.recordType,
                    "changetype": "DELETE",
                }
            ]
        }

        logger.debug("sending GET request to %s" % self.uri)
        zone_check = requests.get(self.uri, headers=self.headers)
        logger.debug("returned %d %s" % (zone_check.status_code, zone_check.text))

        if 200 <= zone_check.status_code <= 300:
            logger.debug("sending PATCH request to %s" % self.uri)
            logger.debug("PATCH body: %s" % json.dumps(payload))
            dummy_r = requests.patch(self.uri, data=json.dumps(payload), headers=self.headers)
            logger.debug("returned %d %s" % (dummy_r.status_code, dummy_r.text))
            logger.info("DNS Record '%s' Successfully Deleted"
                   % (self.args.name + '.' + self.args.zone))
        else:
            logger.error("DNS Zone '%s' Does Not Exist..." % self.args.zone)

    def delete_zone(self):
        """
        Delete DNS Zones
        """
        payload = {
            "name": self.args.zone
        }

        logger.debug("sending GET request to %s" % self.uri)
        zone_check = requests.get(self.uri, headers=self.headers)
        logger.debug("returned %d %s" % (zone_check.status_code, zone_check.text))

        if zone_check.status_code == 200:
            logger.debug("sending DELETE request to %s" % self.uri)
            dummy_r = requests.delete(self.uri, data=json.dumps(payload), headers=self.headers)
            logger.debug("DELETE body: %s" % json.dumps(payload))
            logger.info("DNS Zone '%s' Successfully Deleted..." % self.args.zone)
        else:
            logger.error("DNS Zone '%s' Does Not Exist..." % self.args.zone)

    def query_config(self):
        """
        Query PDNS Config
        """
        logger.debug("sending GET request to %s" % self.uri)
        r = requests.get(self.uri, headers=self.headers)
        logger.debug("returned %d %s" % (r.status_code, r.text))
        python_data = json.loads(r.text)
        print(json.dumps(python_data, indent=4))

    def query_stats(self):
        """
        Query DNS Stats
        """
        logger.debug("sending GET request to %s" % self.uri)
        r = requests.get(self.uri, headers=self.headers)
        logger.debug("returned %d %s" % (r.status_code, r.text))
        python_data = json.loads(r.text)
        print(json.dumps(python_data, indent=4))

    def query_zone(self):
        """
        Query DNS Zones

        Query existing DNS Zones
        """
        logger.debug("sending GET request to %s" % self.uri)
        r = requests.get(self.uri, headers=self.headers)
        logger.debug("returned %d %s" % (r.status_code, r.text))
        if r.status_code == 200:
            python_data = json.loads(r.text)
            print(json.dumps(python_data, indent=4))
        else:
            print("DNS Zone '%s' Does Not Exist..." % self.args.zone)

    def read_cli_args(self):
        """
        Read variables from CLI

        Read CLI variables passed on CLI
        """
        try:
            def_api_key = os.environ['API_KEY']
        except KeyError:
            def_api_key = "changeme"
        try:
            def_web_port = os.environ['WEB_PORT']
        except KeyError:
            def_web_port = '8081'

        parser = argparse.ArgumentParser(description='PDNS Controls...')
        parser.add_argument('action', help='Define action to take',
                            choices=['add_record', 'add_zone', 'delete_record',
                                     'delete_zone', 'query_config', 'query_stats', 'query_zone'])
        parser.add_argument('--apikey', help='PDNS API Key', default=def_api_key)
        parser.add_argument('--apihost', help='PDNS API Host', default='127.0.0.1')
        parser.add_argument('--apiport', help='PDNS API Port', default=def_web_port)
        parser.add_argument('--content', help='DNS Record content, can be specified multiple times', action='append')
        parser.add_argument('--disabled', help='Define if Record is disabled',
                            action='store_true', default=False)
        parser.add_argument('--master', help='DNS zone master, can be specified multiple times', action='append')
        parser.add_argument('--name', help='DNS record name')
        parser.add_argument('--nameserver', help='DNS nameserver for zone, can be specified multiple times', action='append')
        parser.add_argument('--priority', help='Define priority', default=0)
        parser.add_argument('--recordType', help='DNS record type',
                            choices=['A', 'AAAA', 'CNAME', 'MX', 'NS', 'PTR', 'SOA', 'SRV', 'TXT', 'NAPTR'])
        parser.add_argument('--setPTR', help='Define if PTR record is created',
                            action='store_true', default=False)
        parser.add_argument('--ttl', help='Define TTL', default=3600)
        parser.add_argument('--zone', help='DNS zone')
        parser.add_argument('--zoneType', help='DNS Zone Type',
                            choices=['MASTER', 'NATIVE', 'SLAVE'])
        parser.add_argument('--debug', help='Enable debug', action='store_true', default=False)
        self.args = parser.parse_args()
        if self.args.action == "add_zone" and (self.args.zoneType == "MASTER" and
                                                self.args.nameserver is None):
            parser.error("--nameserver is required to create MASTER zone")
        if self.args.action == "add_zone" and (self.args.zoneType == "SLAVE" and
                                                self.args.master is None):
            parser.error("--master is required to create SLAVE zone")

    def setup_api_call(self):
        """
        Setup API Call

        Based on action setup the correct API call to make
        """
        if self.args.debug:
            logger.setLevel(logging.DEBUG)
        self.headers = {'X-API-Key': self.args.apikey}
        if (self.args.action == "add_zone" or (self.args.action == "query_zone" and
                                                self.args.zone is None)):
            self.uri = ("http://%s:%s/api/v1/servers/localhost/zones"
                        % (self.args.apihost, self.args.apiport))
        elif self.args.action == "add_record" \
              or self.args.action == "delete_record" \
              or self.args.action == "delete_zone" \
              or self.args.action == "query_zone":
            self.uri = ("http://%s:%s/api/v1/servers/localhost/zones/%s"
                        % (self.args.apihost, self.args.apiport, self.args.zone))
        elif self.args.action == "query_config":
            self.uri = ("http://%s:%s/api/v1/servers/localhost/config"
                        % (self.args.apihost, self.args.apiport))
        elif self.args.action == "query_stats":
            self.uri = ("http://%s:%s/api/v1/servers/localhost/statistics"
                        % (self.args.apihost, self.args.apiport))

if __name__ == '__main__':
    PDNSControl()
