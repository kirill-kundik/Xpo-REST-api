class ExpoModelSerializer < ActiveModel::Serializer
  attributes :id, :ar_model_url, :marker_url, :expo_id, :created_at, :updated_at
end
