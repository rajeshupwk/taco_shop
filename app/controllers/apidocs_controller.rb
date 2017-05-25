class ApidocsController < ActionController::Base
  include Swagger::Blocks

  HOST = 'taco-shop.herokuapp.com'

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'Taco'
      key :description, 'API documentation for exploring ' \
                        'taco backend end-points.'
    end
    tag do
      key :name, 'Taco'
      key :description, 'Taco'
    end
    key :host, HOST
    key :basePath, '/'
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end

  SWAGGERED_CLASSES = [
    API::V1::TacosController,
    self,
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end

end
