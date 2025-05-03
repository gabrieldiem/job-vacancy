require 'spec_helper'

describe JobOffer do
  describe 'valid?' do
    it 'should be invalid when title is blank' do
      check_validation(:title, "Title can't be blank") do
        described_class.new(location: 'a location', salary: 10, experience_required: 0)
      end
    end

    it 'should be invalid when salary is blank' do
      check_validation(:salary, "Salary can't be blank") do
        described_class.new(title: 'a title', experience_required: 0)
      end
    end

    it 'should be invalid when salary is -1' do
      check_validation(:salary, "Salary can't be negative") do
        described_class.new(title: 'a title', salary: -1, experience_required: 0)
      end
    end

    it 'should be valid when title and salary are not blank' do
      job_offer = described_class.new(title: 'a title', salary: 10, experience_required: 0)
      expect(job_offer).to be_valid
    end

    it 'should be invalid when experience is blank' do
      check_validation(:experience_required, "Experience required can't be blank") do
        described_class.new(title: 'a title', salary: 10)
      end
    end

    it 'should be invalid when experience is negative' do
      check_validation(:experience_required, "Experience required can't be negative") do
        described_class.new(title: 'a title', salary: 10, experience_required: -1)
      end
    end

    it 'should be valid when experience is greater than 0' do
      job_offer = described_class.new(title: 'a title', salary: 10, experience_required: 5)
      expect(job_offer).to be_valid
    end

    it 'should be invalid when experience_required is not numeric' do
      check_validation(:experience_required, 'Experience required Please enter the years as a number') do
        described_class.new(title: 'a title', salary: 10, experience_required: 'two years')
      end
    end
  end

  it 'should have a description of "Remote" when created with it' do
    job_offer = described_class.new(title: 'a title', description: 'Remote', experience_required: 0, salary: 0)
    expect(job_offer.description).to eq 'Remote'
  end

  it 'should have a location of "Korea" when created with it' do
    job_offer = described_class.new(title: 'a title', location: 'Korea', experience_required: 0, salary: 0)
    expect(job_offer.location).to eq 'Korea'
  end

  it 'should have a salary of 10000 when created with it' do
    job_offer = described_class.new(title: 'a title', salary: 10_000, experience_required: 0)
    expect(job_offer.salary).to eq 10_000
    expect(job_offer.is_salary_specified?).to be true
  end

  it 'should have a salary of 200 when created with it' do
    job_offer = described_class.new(title: 'a title', salary: 200, experience_required: 0)
    expect(job_offer.salary).to eq 200
  end

  it 'should have a salary of 300, description of "Remote" and location of "Korea" when created with it' do
    job_offer = described_class.new(title: 'a title', salary: 300, experience_required: 0, description: 'Remote',
                                    location: 'Korea')
    expect(job_offer.salary).to eq 300
    expect(job_offer.description).to eq 'Remote'
    expect(job_offer.location).to eq 'Korea'
  end

  it 'should have a "Not specified" salary when created with 0 salary' do
    job_offer = described_class.new(title: 'a title', salary: 0, experience_required: 0)
    expect(job_offer.is_salary_specified?).to be false
  end

  it 'The salary number to declare a salary as "Not specified" is 0' do
    expect(described_class.unspecified_salary_number).to be 0
  end

  it 'should have "No experience required" when experience required is 0' do
    job_offer = described_class.new(title: 'a title', experience_required: 0, salary: 0)
    expect(job_offer.is_experience_specified?).to be false
  end

  it 'The experience required to declare it as "No experience required" is 0' do
    expect(described_class.no_experience_required).to be 0
  end

  it 'A JobOffer created as inactive is inactive' do
    offer = described_class.new(title: 'a title', salary: 0, experience_required: 0, is_active: false)
    expect(offer.is_active?).to be false
  end

  it 'should have a experience required of 1 when created with it' do
    job_offer = described_class.new(title: 'a title', salary: 200, experience_required: 1)
    expect(job_offer.experience_required).to eq 1
  end
end
