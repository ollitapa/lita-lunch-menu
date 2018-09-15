require 'spec_helper'
require 'timecop'

describe Lita::Handlers::LunchMenu, lita_handler: true do
  before do
    Timecop.freeze(Time.local(2018, 9, 15))
  end

  after do
    Timecop.return
  end

  it { is_expected.to route('lunch reaktori').to(:lunch) }
  it 'it gets menu for "reaktori"' do
    stub_request(:get, 'https://www.fazerfoodco.fi/modules/json/json/Index?costNumber=0812&language=en')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host' => 'www.fazerfoodco.fi',
          'User-Agent' => 'Ruby'
        }
      )
      .to_return(status: 200, body: '
{
  "RestaurantName": "Reaktori",
  "RestaurantUrl": "http://www.fazerfoodco.fi/en/restaurants/Ravintolat-kaupungeittain/tampere/reaktori/",
  "PriceHeader": null,
  "Footer": "Bon appétit!",
  "MenusForDays": [
    {
      "Date": "2018-09-15T00:00:00+02:00",
      "LunchTime": "11.00 - 14.45",
      "SetMenus": [
        {
          "SortOrder": 0,
          "Name": "vegetarian lunch",
          "Price": "2,60/ 4,95/ 7,60 €",
          "Components": [
            "Vegetables Bolognese (* ,A ,G ,L ,M ,Veg)",
            "Whole grain organic spaghetti (* ,A ,L ,M ,Veg)"
          ]
        }
      ]
    },
    {
      "Date": "2018-09-16T00:00:00+02:00",
      "LunchTime": null,
      "SetMenus": []
    }
  ],
  "ErrorText": null
}
', headers: {})

    send_message('lunch reaktori')

    expect(replies.last).to eq("( つ ◕_◕ )つ Today at Reaktori\n\nVegetables Bolognese \n-----------\nWhole grain organic spaghetti ")
  end
end
