module API::V1::Entities
  class TacoEntity < Grape::Entity
    expose :meat
    expose :rice
    expose :salsa
    expose :note
  end
end
