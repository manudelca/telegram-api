WebTemplate::App.controllers :content, :provides => [:json] do
  post :create, :map => '/content' do
    content_params.each do |content|
      create_content_and_get_json(content[:type], content)
    end

    status 201
    {
      :message => 'El contenido fue registrado exitosamente!',
      :content => { }
    }.to_json
  end
end
