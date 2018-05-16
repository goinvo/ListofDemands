Geocoder.configure(ip_lookup: :test)

def stub_arlington_geoip
  Geocoder::Lookup::Test.add_stub(
    "0.0.0.0",
    [
      {
        'coordinates'  => [42.4154, -71.1565],
        'address'      => 'Arlington, MA, USA',
        'state'        => 'Massachusetts',
        'zip'          => '02474',
        'state_code'   => 'MA',
        'country'      => 'United States',
        'country_code' => 'US'
      }
    ]
  )
end
