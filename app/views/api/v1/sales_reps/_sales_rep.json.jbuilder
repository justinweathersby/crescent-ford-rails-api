json.extract! sales_rep, :id, :name, :created_at, :updated_at
json.image sales_rep.image(:thumb)
json.role "Sales Representative" 
json.unique_id sales_rep.unique_id