class AddTermsAcceptedToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :terms_accepted, :boolean
  end
end
