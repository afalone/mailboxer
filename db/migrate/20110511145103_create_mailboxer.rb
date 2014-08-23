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
      t.references :receiver, :polymorphic => true, :foreign_key => { references: [:receiver_id, :receiver_type] }
      t.column :notification_id, :integer, :null => false, :index => true, :foreign_key => "receipts_on_notification_id"
      t.column :is_read, :boolean, :default => false
      t.column :trashed, :boolean, :default => false
      t.column :deleted, :boolean, :default => false
      t.column :mailbox_type, :string, :limit => 25
      t.column :created_at, :datetime, :null => false
      t.column :updated_at, :datetime, :null => false
    end
  	#Notifications and Messages
    create_table :mailboxer_notifications do |t|
      t.column :type, :string, :foreign_key => true, index: true
      t.column :body, :text
      t.column :subject, :string, :default => ""
      t.references :sender, :polymorphic => true, :foreign_key => { references: [:sender_id, :sender_type] }
      t.column :conversation_id, :integer, :index => true, :foreign_key => "notifications_on_conversation_id"
      t.column :draft, :boolean, :default => false
      t.string :notification_code, :default => nil
      t.references :notified_object, :polymorphic => true, :foreign_key => { references: [:notified_object_id, :notified_object_type], name: 'index_mailboxer_notifications_on_notified_object_id_and_type' }
      t.column :attachment, :string
      t.column :updated_at, :datetime, :null => false
      t.column :created_at, :datetime, :null => false
      t.boolean :global, default: false
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
