require 'aws-sdk'
require 'backsnap/version'
require 'backsnap/settings'
require 'backsnap/init'

module Backsnap
  class Snapshot
    attr_accessor :region

    def initialize(region = 'us-east-1')
      self.region = region
    end

    def create(route53_name, snapshot_name)
      rds = AWS::RDS.new(region: region)
      rds.client.create_db_snapshot(db_instance_identifier: db_instance_id(route53_name),
                                    db_snapshot_identifier: snapshot_name)
    end

    def status snapshot_name
      rds = AWS::RDS.new(region: region)
      snapshot = rds.db_snapshots.find { |ss| ss.db_snapshot_id == snapshot_name }
      snapshot.status
    end

    def copy(source_snapshot, target_snapshot,
                      source_region = region, target_region = region) 

      rds = AWS::RDS.new(region: target_region)
      rds.client.copy_db_snapshot(source_db_snapshot_identifier: arn(source_snapshot, source_region),
                                    target_db_snapshot_identifier: target_snapshot)
    end

    private

    def arn resource, region
      "arn:aws:rds:#{region}:#{Settings.aws['account']}:snapshot:#{resource}"
    end

    def db_instance_id route53_name
      rds = AWS::RDS.new
      instance = rds.db_instances.find { |db| db.endpoint_address == end_point(route53_name) }
      instance.db_instance_id
    end

    def end_point route53_name
      r53  = AWS::Route53.new
      sets = r53.hosted_zones[Settings.aws['hosted_zone_id']].resource_record_sets
      r    = sets.find { |rs| rs.name == add_end_dot(route53_name) }
      r.resource_records.first[:value].split(':').first
    end

    def add_end_dot name
      name[-1] == '.' ? name : name + '.'
    end

  end
end
