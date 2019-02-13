# lnx ⚡️

Use lnx to deploy and manage a multi-region constellation of Lightning Network nodes.

**Features**

- [x] Each node runs [lnd](https://github.com/lightningnetwork/lnd) with autopilot on.
- [x] Each node runs its own [Bitcoin](https://github.com/bitcoin/bitcoin) full node. The blocks are snapshotted for quick bootstrap/recovery.
- [x] Multiple AWS regions: US East, US West, Asia Pacific (Singapore), EU (Frankfurt), South America (São Paulo)
- [x] Friendly hostnames: _subdomain_._domain_._com_

**Security**

- [x] Nodes are deployed in separate VPCs and may only be managed through bastion hosts.
- [x] Hot wallets are encrypted at rest.
- [ ] Route inbound traffic through NAT.
- [ ] Separate dev-ops and channel admin authorization roles.

**Ops**

- [x] Infrastructure resources are codified and managed with Terraform.
- [x] Collect and view application logs in CloudWatch Logs.
- [ ] Monitor node health with CloudWatch alarms.
- [ ] Monitor lnd application metrics (# of open channels, balance, etc.) with CloudWatch metrics.

**Audit**

- [ ] Audit infra access with AWS CloudTrail.
- [ ] Archive application logs indefinitely in S3.
