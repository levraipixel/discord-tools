class AddDataModels < ActiveRecord::Migration[6.0]
  def change
    create_table :guilds do |t|
      t.string :discord_id

      t.string :name
    end

    add_index :guilds, :discord_id, unique: true

    create_table :channels do |t|
      t.string :discord_id

      t.belongs_to :guild, index: true
      t.belongs_to :parent, index: true

      t.string :name
      t.integer :position
      t.string :topic
      t.boolean :is_imported
    end

    add_index :channels, :discord_id, unique: true
    add_index :channels, :position

    create_table :messages do |t|
      t.string :discord_id

      t.belongs_to :channel, index: true

      t.string :author
      t.text :content
    end

    add_index :messages, :discord_id, unique: true
  end
end
