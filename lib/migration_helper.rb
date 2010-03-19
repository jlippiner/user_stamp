module UserStamp
  module MigrationHelper
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)
    end

    module InstanceMethods
      def userstamps(include_deleted_by = false)
        column(:creator_id, :integer)
        column(:updater_id, :integer)
      end
    end

    module SchemaStatements
      # Adds userstamps (creator_id and updater_id) columns to the named table.
      # ===== Examples
      #  add_userstamps(:suppliers)
      def add_userstamps(table_name)
        add_column table_name, :creator_id, :integer
        add_column table_name, :updater_id, :integer
      end

      # Remove userstamps (creator_id and updater_id) columns from the named table.
      # ===== Examples
      # remove remove_userstamps(:suppliers)
      def remove_userstamps(table_name)
        remove_column table_name, :creator_id
        remove_column table_name, :updater_id
      end
    end

  end
end

ActiveRecord::ConnectionAdapters::TableDefinition.send(:include, UserStamp::MigrationHelper)
ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.send(:include, UserStamp::MigrationHelper::SchemaStatements)
