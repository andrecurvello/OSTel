class CreateKamailioVersionTable < ActiveRecord::Migration
  def self.up
    # this is a system table for kamailio and will never have a Rails model.
    # Rails requires a primary key to be created if using the create_table
    # method.
    execute "CREATE TABLE version (table_name VARCHAR(32) NOT NULL, table_version INTEGER DEFAULT 0 NOT NULL)"
    # kamailio also uses some internal versioning system in the database. The
    # version strings for each table are set in SQL files distributed upstream.
    # I have copied them here...this does not scale.
    # 
    # I have used the table_name of 'users' here, which corresponds to the Rails
    # model. I would like to avoid using views, though it might be a good idea
    # to eventually migrate the whole kamailio database to postgres.
    execute "INSERT INTO version (table_name, table_version) VALUES ('users','6')"
  end

  def self.down
    drop_table :version
  end
end
