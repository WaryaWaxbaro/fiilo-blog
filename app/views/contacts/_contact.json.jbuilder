json.extract! contact, :id, :name, :email, :phone, :message, :extra_info, :created_at, :updated_at
json.url contact_url(contact, format: :json)
