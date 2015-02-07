# This resource manages an individual rule that applies to the file defined in
# $target. See README.md for more details.
define postgresql::server::recovery_rule(
  $restore_command = '',
  $archive_cleanup_command = '',
  $recovery_end_command = '',
  $recovery_target_name = '',
  $recovery_target_time = '',
  $recovery_target_xid = '',
  $recovery_target_inclusive = true,
  $recovery_target = 'immediate',
  $recovery_target_timeline = 'latest',
  $pause_at_recovery_target = true,
  $standby_mode = 'off',
  $primary_conninfo = '',
  $primary_slot_name = '',
  $trigger_file = '',
  $recovery_min_apply_delay = 0,

  # Needed for testing primarily, support for multiple files is not really
  # working.
  $target      = $postgresql::server::pg_hba_conf_path
) {

  if $postgresql::server::manage_recovery_conf == false {
    fail('postgresql::server::manage_pg_ident_conf has been disabled, so this resource is now unused and redundant, either enable that option or remove this resource from your manifests')
  } else {

    # Create a rule fragment
    $fragname = "pg_ident_rule_${name}"
    concat::fragment { $fragname:
      target  => $target,
      content => template('postgresql/pg_ident_rule.conf'),
      order   => $order,
    }
  }
}
