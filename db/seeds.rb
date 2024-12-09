# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# Clear the database to avoid duplication errors
puts "Clearing the database"
Admin.destroy_all
puts "Creating admin"
admin = Admin.create(email: ENV['ADMIN_EMAIL'], password: ENV['ADMIN_PASSWORD'], password_confirmation: ENV['ADMIN_PASSWORD'])
if admin.persisted?
  puts "Admin created successfully"
else
  puts "Error creating admin: #{admin.errors.full_messages.join(", ")}"
end
