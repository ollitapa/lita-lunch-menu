require 'net/http'

module Lita
  module Handlers
    # Handler for lunch questions.
    class LunchMenu < Handler
      @@restaurants =
        { 'garden' => proc { fazer_lunch(3497) },
          'biergartten' =>  proc { fazer_lunch(3497) },
          'kartten' =>  proc { fazer_lunch(3497) },
          'smart' =>  proc { fazer_lunch(3498) },
          'smartti' =>  proc { fazer_lunch(3498) },
          'smarthouse' =>  proc { fazer_lunch(3498) },
          'reaktori' => proc { fazer_lunch('0812') },
          'vtt' =>  proc { fazer_lunch(3587) },
          'vtt-oulu' =>  proc { fazer_lunch(3587) },
          'kara3' =>  proc { fazer_lunch(3205) },
          'karaportti3' =>  proc { fazer_lunch(3205) },
          'vtt-espoo' =>  proc { fazer_lunch(3588) },
          'micronova' =>  proc { fazer_lunch(3588) },
          'aalto' =>  proc { fazer_lunch(3579) },
          'vm5' =>  proc { fazer_lunch(3579) } }

      route(/^lunch\s+(.+)/, :lunch, help: { 'lunch PLACE' => 'Provides Menu of given lunch place.' })

      def lunch(response)
        restaurant_name = response.matches[0][0]
        # response.reply(restaurant_name)
        renstaurant_provider = @@restaurants[restaurant_name]
        if renstaurant_provider.nil?
          response.reply('(¬_¬) I do not know that restaurant. (¬_¬)')
          return
        end
        response.reply(renstaurant_provider.call)
      end
      Lita.register_handler(self)
    end
  end
end

def fazer_lunch(at_restaurant_id)
  begin
    uri = URI('https://www.fazerfoodco.fi/modules/json/json/Index')
    params = { costNumber: at_restaurant_id, language: 'en' }
    uri.query = URI.encode_www_form(params)
    http_response = Net::HTTP.get_response(uri)

    data = MultiJson
           .load(http_response.body)

    name = data['RestaurantName'] || 'Somewhere'
    menu = data['MenusForDays']
           .find { |a| Date.parse(a['Date']) === Date.today }['SetMenus']
           .flat_map { |a| a['Components'] }
           .map { |food| food.split('(')[0] }
           .join("\n-----------\n")
  rescue MultiJson::ParseError => exception
    return '(╯°□°）╯︵ ┻━━┻  Restaurant api is broken!' + exception
  rescue StandardError
    return '(╯°□°）╯︵ ┻━━┻  Nothing found! Starve!'
  end

  "( つ ◕_◕ )つ Today at #{name}\n\n#{menu}"
end
