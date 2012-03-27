require 'spec_helper'

describe Movie do
  before(:each) do
    @m1 = FactoryGirl.build(:movie, :title => 'Star Wars', :director => 'George Lucas')
    @m2 = FactoryGirl.build(:movie, :title => 'Blade Runner', :director => 'Ridley Scott')
    @m3 = FactoryGirl.build(:movie, :title => 'Alien', :director => '')
    @m4 = FactoryGirl.build(:movie, :title => 'THX-1138', :director => 'George Lucas')
    @m1.save!
    @m2.save!
    @m3.save!
    @m4.save!    
  end
  describe 'Find movies with same director' do
    it 'should return all movies with same director given movie director field is not empty' do
      movies = Movie.find_with_same_director(@m1.id) 
      movies.count.should == 2
      movies.should be_include @m1
      movies.should be_include @m4
    end
    it 'should return empty array given director fields is empty' do
      Movie.find_with_same_director(@m3.id).should == []
    end
  end
end
