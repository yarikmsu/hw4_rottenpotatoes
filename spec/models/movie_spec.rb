require 'spec_helper'

describe Movie do
  describe 'Find movies with same director' do
    it 'should return all movies with same director given director fiels is not empty' do
      m1 = FactoryGirl.build(:movie, :title => 'Star Wars', :director => 'George Lucas')
      m2 = FactoryGirl.build(:movie, :title => 'Blade Runner', :director => 'Ridley Scott')
      m3 = FactoryGirl.build(:movie, :title => 'Alien', :director => '')
      m4 = FactoryGirl.build(:movie, :title => 'THX-1138', :director => 'George Lucas')
      m1.save!
      m2.save!
      m3.save!
      m4.save!
      Movie.find_with_same_director(m1.id).count.should == 2
      Movie.find_with_same_director(m1.id).should be_include m1
      Movie.find_with_same_director(m1.id).should be_include m4
    end
  end
end
