module API
  module V1
    class TacosController < Grape::API
      include API::V1::Defaults

      resource :tacos do

        desc 'Return all tacos'
        get do
          tacos = Taco.all
          present tacos, with: API::V1::Entities::TacoEntity
        end

        desc 'Create new taco'
        params do
          requires :meat, type: String
          requires :rice, type: String
          requires :salsa, type: String
          requires :note, type: String
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
          @taco = Taco.find(params[:id]).destroy
          #present @taco
        end
      end
    end
  end
end
