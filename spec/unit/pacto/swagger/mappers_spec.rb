module Pacto
  module Swagger

      describe 'endpoint path' do

        it 'should handle path with no params' do
          contract = {
            'request' => {
              'path' => 'www.host.com/users',
              'schema' => {}
            }
          }

          obj = Pacto::Swagger::Parameters.get(contract)

          expect(obj).to eq([])
        end

        it 'should get a single parameter from contract' do
          contract = {
            'request' => {
              'path' => 'www.host.com/users?name=dude',
              'schema' => {}
            }
          }

          obj = Pacto::Swagger::Parameters.get(contract)

          expect(obj).to eq([{
            "name" => 'name',
            "in" => "query",
            "description" => "Query Parameter",
            "required" => true,
            "type" => "string"
            }])
        end

        it 'should get multiple parameters from contract' do
          contract = {
            'request' => {
              'path' => 'www.host.com/users?name=dude&age=10',
              'schema' => {}
            }
          }

          obj = Pacto::Swagger::Parameters.get(contract)

          expect(obj).to eq([{
            "name" => 'name',
            "in" => "query",
            "description" => "Query Parameter",
            "required" => true,
            "type" => "string"
            },
            {
              "name" => 'age',
              "in" => "query",
              "description" => "Query Parameter",
              "required" => true,
              "type" => "string"
              }
              ])
        end

        it 'should get parameters with body from contract' do
          schema = {
            "$schema" => "http://json-schema.org/draft-04/schema#",
            "type" => "object",
            "properties" => {
              "items" => {
                "type" => "array",
                "items" => {
                  "type" => "object",
                  "properties" => {
                    "itemId" => {
                      "type" => "string"
                    }
                  }
                }
              }
            }
          }
          contract = {
            'request' => {
              'path' => 'www.host.com/users?name=dude',
              'schema' => schema
            }
          }

          obj = Pacto::Swagger::Parameters.get(contract)

          expect(obj).to eq([{
            "name" => 'name',
            "in" => "query",
            "description" => "Query Parameter",
            "required" => true,
            "type" => "string"
            },
            {
             "name" => "body",
             "in" => "body",
             "description" => "Request Body",
             "required" => true,
             "schema" => schema
            }
            ])
      end
    end

    describe 'endpoint response' do
      it 'should build swagger response' do
        contract = {
          'response' => {
            'status' => 200,
            'description' => 'Response description',
            'schema' => {}
          }
        }

        obj = Pacto::Swagger::Responses.get(contract)

        expect(obj).to eq({
            200=>{
              "description"=>"Response description",
              "schema"=>{}
            }
          })
      end
    end

  end
end