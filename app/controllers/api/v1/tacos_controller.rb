module API
  module V1
    class TacosController < Grape::API
      include API::V1::Defaults
      include Swagger::Blocks

      # Documentation
      swagger_path '/api/v1/tacos' do
        operation :get do
          key :description, 'Returns all tacos from the system'
          key :operationId, 'allTacos'
          key :produces, [
            'application/json',
          ]
          key :tags, [
            'taco'
          ]
          response 200 do
            key :description, 'taco response'
          end
          response :default do
            key :description, 'unexpected error'
          end
        end

        operation :post do
          key :description, 'Create new taco'
          key :operationId, 'newTacos'
          key :produces, [
            'application/json',
          ]
          key :tags, [
            'taco'
          ]
          parameter do
            key :name, :meat
            key :in, :query
            key :description, 'provide 0 for chicken or 1 for steak'
            key :required, true
            key :type, :integer
          end
          parameter do
            key :name, :rice
            key :in, :query
            key :description, 'Check here for rice'
            key :required, false
            key :type, :boolean
          end
          parameter do
            key :name, :salsa
            key :in, :query
            key :description, 'Check here for salsa'
            key :required, false
            key :type, :boolean
          end
          parameter do
            key :name, :note
            key :in, :query
            key :description, 'Add note here'
            key :required, false
            key :type, :text
          end
          response 200 do
            key :description, 'taco response'
          end
          response :default do
            key :description, 'unexpected error'
          end
        end
      end

      swagger_path '/api/v1/tacos/{id}' do
        operation :delete do
          key :description, 'Delete record for provided id'
          key :operationId, 'deleteTaco'
          key :tags, [
            'delete taco'
          ]
          parameter do
            key :name, :id
            key :in, :path
            key :description, 'ID of record to delete'
            key :required, true
            key :type, :integer
          end
          response 200 do
            key :description, 'pet response'
          end
          response :default do
            key :description, 'unexpected error'
          end
        end
        operation :get do
          key :description, 'Return saved record by id'
          key :operationId, 'getTaco'
          key :tags, [
            'get taco'
          ]
          parameter do
            key :name, :id
            key :in, :path
            key :description, 'ID of record to delete'
            key :required, true
            key :type, :integer
          end
          response 200 do
            key :description, 'pet response'
          end
          response :default do
            key :description, 'unexpected error'
          end
        end
      end


      resource :tacos do

        desc 'Return all tacos'
        get do
          tacos = Taco.all
          present tacos, with: API::V1::Entities::TacoEntity
        end

        desc 'Create new taco'
        params do
          requires :meat, type: Integer
        end
        post do
          @taco = Taco.create({
            :meat => params[:meat],
            :rice => params[:rice],
            :salsa => params[:salsa],
            :note => params[:note]
            })
          present @taco, with: API::V1::Entities::TacoEntity
        end

        desc 'Delete a taco'
        params do
          requires :id, type: String, desc: 'Taco ID.'
        end
        delete ':id' do
          Taco.find(params[:id]).destroy
          present nil
        end

        desc 'Return a taco'
        params do
          requires :id, type: String, desc: 'Taco ID.'
        end
        get ':id' do
          @taco = Taco.find(params[:id])
          present @taco, with: API::V1::Entities::TacoEntity
        end
      end
    end
  end
end
