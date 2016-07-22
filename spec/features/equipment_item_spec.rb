require 'spec_helper'

describe 'Equipment Items', type: :feature do
  describe 'creation' do
    let!(:model) { FactoryGirl.create(:equipment_model) }
    before { sign_in_as_user @superuser }
    it 'succeeds' do
      visit equipment_model_path(model)
      click_on "Create New #{model.name} Item"
      fill_in('Name', with: 'New Item Name')
      click_button 'Create Equipment item'
      expect(EquipmentItem.where(name: 'New Item Name')).not_to be_empty
    end
  end
  describe 'editing' do
    let!(:item) { FactoryGirl.create(:equipment_item) }
    before { sign_in_as_user @superuser }
    shared_examples 'can update' do |attr, value|
      it attr.to_s do
        visit edit_equipment_item_path(item)
        fill_in("equipment_item_#{attr}", with: value)
        click_button 'Update Equipment item'
        item.reload
        expect(item.send(attr)).to eq(value)
      end
    end
    ATTRS = { name: 'ITEM', serial: '12345' }.freeze
    ATTRS.each { |attr, value| it_behaves_like 'can update', attr, value }
  end
end