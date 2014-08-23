class AddConversationOptout < ActiveRecord::Migration
  def self.up
    create_table :mailboxer_conversation_opt_outs do |t|
      t.references :unsubscriber, :polymorphic => true, :foreign_key => { references: [:unsubscriber_id, :unsubscriber_type], name: 'index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type'}
      t.references :conversation, :foreign_key => { :name => "mailboxer_conversations" }, :index => true
    end
  end

  def self.down
    drop_table :mailboxer_conversation_opt_outs
  end
end
