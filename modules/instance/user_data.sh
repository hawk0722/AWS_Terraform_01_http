#!/bin/bash

yum -y update
yum -y install httpd
systemctl enable httpd.service
systemctl start httpd.service
