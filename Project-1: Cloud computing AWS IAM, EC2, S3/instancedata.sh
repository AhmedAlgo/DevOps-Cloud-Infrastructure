#!/bin/bash
# assign variables
touch metadata.txt
curl http://169.254.169.254/latest/meta-data/hostname -w "\n" >> metadata.txt
curl http://169.254.169.254/latest/meta-data/iam/info/ -w "\n" >> metadata.txt
curl http://169.254.169.254/latest/meta-data/security-groups -w "\n" >> metadata.txt
exit 1
esac

