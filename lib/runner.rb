require 'backsnap'
require 'thor'
require 'highline/import'

class Runner < Thor

  desc 'create_snapshot snapshot_name', 'create a snapshot from a Route53 url'
  option :region, default: 'us-east-1'
  option :from_url, required: true
  def create_snapshot(name)
    region = options['region']
    if agree "Should I create snapshot '#{name}' using '#{options['from_url']}' in the '#{region}' region? (Y or N)"
      say 'Creating snapshot...'
    else
      say 'Snapshot creation canceled!'
    end
  end

  desc 'copy_snapshot from_snapshot to_snapshot', 'copy a snapshot'
  option :to_region, default: 'us-east-1'
  option :from_region, default: 'us-east-1'
  def copy_snapshot(from, to)
    to_region   = options['to_region']
    from_region = options['from_region']

    if agree "Should I copy snapshot '#{from}(#{from_region})' to '#{to}(#{to_region})'? (Y or N)"
      say 'Copying snapshot...'
    else
      say 'Snapshot copy canceled!'
    end
  end

  desc 'restore_database database_name', 'restores a database from a snapshot'
  option :region, default: 'us-east-1'
  option :snapshot, required: true
  def restore_database(name)
    region = options['region']
    if agree "Should I restore database '#{name}' from '#{options['snapshot']}' in #{region}? (Y or N)"
      say 'Copying snapshot...'
    else
      say 'Snapshot copy canceled!'
    end
  end

  desc 'copy database_name URL', 'copies a database'
  option :from_region, default: 'us-east-1'
  option :to_region, default: 'us-east-1'
  option :snapshot_name, desc: 'temporary snapshot name'
  option :to_database, required: true
  option :to_url
  option :security_groups
  def copy_database(name)
    # find database endpoint using url
    # create a snapshot of database
    # wait till snapshot is ready
    # copy snapshot to a different region if necesssary
    #   wait till copy is ready
    # restore database
    # wait till database is restored
    # update database security groups
    # update route53 url
  end
end
