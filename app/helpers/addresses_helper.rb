module AddressesHelper
  require 'tel_formatter'

  def postal_code(postal_code)
    "〒#{postal_code.to_s.insert(3, "-")}"
  end

  def building(building)
    building.present? ? (building) : ("建物名は登録されていません")
  end

  def phone_number(phone_number)
    return "電話番号は登録されていません" if phone_number.blank?
    TelFormatter.format(phone_number)
  end
end
