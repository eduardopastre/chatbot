class CreateUserFaqs < ActiveRecord::Migration[5.1]
  def change
    create_table :user_faqs do |t|
      t.integer :user_id
      t.integer :faq_id
    end
  end
end
