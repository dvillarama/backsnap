require 'aws-sdk'
require 'backsnap/version'
require 'backsnap/settings'
require 'backsnap/init'

module Backsnap
  class Database
    attr_accessor :region

    def initialize(region = 'us-east-1')
      self.region = region
    end

    def restore(name, snapshot_name)
      rds = AWS::RDS.new(region: region)
      rds.restore_db_instance_from_db_snapshot(db_instance_identifier: name, db_snapshot_identifier: snapshot_name)
    end
  end
end
