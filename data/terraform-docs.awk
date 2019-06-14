# This script converts Terraform 0.12 variables/outputs to something suitable for `terraform-docs`
# As of terraform-docs v0.6.0, HCL2 is not supported. This script is a *dirty hack* to get around it.
# https://github.com/segmentio/terraform-docs/
# https://github.com/segmentio/terraform-docs/issues/62

# Script was originally found here: https://github.com/cloudposse/build-harness/blob/master/bin/terraform-docs.awk

{
  if ( /\{/ ) {
    braceCnt++
  }

  if ( /\}/ ) {
    braceCnt--
  }

  if ($0 ~ /(variable|output) "(.*?)"/) {
    blockCnt++
    print $0
  }

  if (blockCnt > 0) {
    if ($1 == "description") {
      print $0
    }
  }

  if (blockCnt > 0) {
    if ($1 == "default") {
      if (braceCnt > 1) {
        print "  default = {}"
      } else {
        print $0
      }
    }
  }

  if (blockCnt > 0) {
    if ($1 == "type" ) {
      type=$3
      if (type ~ "object") {
        print "  type = \"object\""
      } else {
        print "  type = \"" $3 "\""
      }
    }
  }

  if (blockCnt > 0) {
    if (braceCnt == 0 && blockCnt > 0) {
      blockCnt--
      print $0
    }
  }
}
