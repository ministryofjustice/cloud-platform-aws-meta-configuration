# Backup etcd Persistant Volumes 

Terraform created to backup etcd persistant volumes within an AWS account


### Set environment variables

```
$ export AWS_PROFILE=<profile_name>
```

Set state store bucket name in `main.tf`
```
bucket = "cloud-platform-<account_name>-etcdbackup-terraform-state"
```

### Bucket Names

| AWS Account | Bucket Name |
|------|-------------|
| moj-platforms-intergration | cloud-platform-intergration-etcdbackup-terraform-state |
| cloud-platform-aws | cloud-platform-aws-etcdbackup-terraform-state |

### Terraform Execution

To run you need to execute the below in the terraform directory:

```
$ Terraform init
$ Terraform plan
$ Terraform apply
```

The following will be created:

| Action | Name |
|------|-------------|
| aws_iam_role.dlm_lifecycle_role | dlm-lifecycle-role |
| aws_iam_policy.dlm_policy | dlm-policy |
| aws_iam_role_policy_attachment.dlm_attach | dlm_attach |
| aws_dlm_lifecycle_policy.etcd_backup | etcd data lifecycle policy |

### Etcd Data Lifecycle Policy Values

| Name | Value |
|------|-------------|
| Schedule name | Daily 2 week etcd snapshots |
| interval | 24 |
| interval_unit | HOURS |
| times         | 06:00 |
| retain_rule count | 14 |
|tags_to_add | SnapshotCreator:DLM |
|target_tags | k8s.io/role/master:1 |

### *** Additional Step ***

Due to a missing reference in Terraform (CopyTags), once the dlm policy has been created, log into the console, find the policy under EC2 > EBS > Lifecycle Manager, highlight the policy and click modify snapshot. Enable the checkbox for `Copy Tags`

### Restore Process

Go to EC2 > EBS > Snapshots. Find the appopiate backups, all tags including name tag will be present for each PV backed up. Once selected, click Actions > Create Volume.  