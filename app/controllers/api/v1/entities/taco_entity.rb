module API::V1::Entities
  class TacoEntity < Grape::Entity
    expose :id
    expose :meat
    expose :rice
    expose :salsa
    expose :note
  end
end
