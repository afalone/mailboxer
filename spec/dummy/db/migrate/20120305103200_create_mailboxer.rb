class CreateMailboxer < ActiveRecord::Migration
  def self.up    
  #Tables
  	#Conversations
    create_table :mailboxer_conversations do |t|
      t.column :subject, :string, :default => ""
      t.column :created_at, :datetime, :null => false
      t.column :updated_at, :datetime, :null => false
    end    
  	#Receipts
    create_table :mailboxer_receipts do |t|
      t.references :receiver, :polymorphic => true
      t.column :notification_id, :integer, :null => false, index: true
      t.column :is_read, :boolean, :default => false
      t.column :trashed, :boolean, :default => false
      t.column :deleted, :boolean, :default => false
      t.column :mailbox_type, :string, :limit => 25
      t.column :created_at, :datetime, :null => false
      t.column :updated_at, :datetime, :null => false
    end    
  	#Notifications and Messages
    create_table :mailboxer_notifications do |t|
      t.column :type, :string
      t.column :body, :text
      t.column :subject, :string, :default => ""
      t.references :sender, :polymorphic => true
      t.references :notified_object, :polymorphic => true
      t.string :notification_code, :default => nil
      t.column :conversation_id, :integer, index: true
      t.column :draft, :boolean, :default => false
      t.column :attachment, :string
      t.column :updated_at, :datetime, :null => false
      t.column :created_at, :datetime, :null => false
      t.boolean :global, :default => false
      t.datetime :expires
    end    
  end
  
  def self.down
  #Tables  	
    drop_table :mailboxer_receipts
    drop_table :mailboxer_conversations
    drop_table :mailboxer_notifications
  end
end
