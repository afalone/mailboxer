class AddConversationOptout < ActiveRecord::Migration
  def self.up
    create_table :mailboxer_conversation_opt_outs do |t|
      t.references :unsubscriber, :polymorphic => true
      t.references :conversation
    end
  end

  def self.down
    drop_table :mailboxer_conversation_opt_outs
  end
end
