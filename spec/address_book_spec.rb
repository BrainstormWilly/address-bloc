require_relative '../models/address_book'

RSpec.describe AddressBook do

  let(:book) { AddressBook.new }

  def check_entry(entry, expected_name, expected_number, expected_email)
    expect(entry.name).to eq expected_name
    expect(entry.phone_number).to eq expected_number
    expect(entry.email).to eq expected_email
  end

  def check_csv(file_name, entries)
    it 'imports the correct number of entries' do
      book.import_from_csv(file_name)
      book_size = book.entries.size
      expect(book_size).to eq entries_hash.size
    end
    entries.each.with_index do |v,i|
      it "imports the entry #{i} of #{file_name}" do
        book.import_from_csv(file_name)
        entry = book.entries[0]
        check_entry(entry, v[:name], v[:number], v[:email])
      end
    end
  end

  describe 'attributes' do
    it 'responds to entries' do
      expect(book).to respond_to(:entries)
    end

    it 'initializes entries as on array' do
      expect(book.entries).to be_an(Array)
    end

    it 'initializes entries as empty' do
      expect(book.entries.size).to eq(0)
    end
  end

  describe '#add_entry' do
    it 'adds only one entry to the address book' do
      book.add_entry('Bill Langley', '707.237.6904', 'brainstormwilly@gmail.com')
      expect(book.entries.size).to eq(1)
    end

    it 'adds the correct information to entries' do
      book.add_entry('Bill Langley', '707.237.6904', 'brainstormwilly@gmail.com')
      new_entry = book.entries[0]
      check_entry(new_entry, 'Bill Langley', '707.237.6904', 'brainstormwilly@gmail.com')
    end
  end

  describe '#import_from_csv' do

    files = [
      ['entries.csv',
        [
          { name: 'Bill', number: '555-555-4854', email: 'bill@blocmail.com' },
          { name: 'Bob', number: '555-555-5415', email: 'bob@blocmail.com' },
          { name: 'Joe', number: '555-555-3660', email: 'joe@blocmail.com' },
          { name: 'Sally', number: '555-555-4646', email: 'sally@blocmail.com' },
          { name: 'Sussie', number: '555-555-2036', email: 'sussie@blocmail.com' }
        ]
      ],
      ['entries_2.csv',
        [
          { name: 'Jane', number: '555-555-0000', email: 'jane@blocmail.com' },
          { name: 'Janice', number: '555-555-1111', email: 'jan@blocmail.com' },
          { name: 'Jerry', number: '555-555-2222', email: 'jerry@blocmail.com' }
        ]
      ]
    ]

    files.each do |f|
      it "imports the correct number of entries for #{f[0]}" do
        book.import_from_csv(f[0])
        book_size = book.entries.size
        expect(book_size).to eq f[1].size
      end

      f[1].each.with_index do |v,i|
        it "imports the entry #{i} of file #{f[0]}" do
          book.import_from_csv(f[0])
          entry = book.entries[i]
          check_entry(entry, v[:name], v[:number], v[:email])
        end
      end

    end

    # it 'imports the correct number of entries' do
    #   book.import_from_csv('entries.csv')
    #   book_size = book.entries.size
    #   expect(book_size).to eq 5
    # end
    # it "imports the 1st entry" do
    #   book.import_from_csv('entries.csv')
    #   entry_one = book.entries[0]
    #   check_entry(entry_one,'Bill','555-555-4854','bill@blocmail.com')
    # end
    # it "imports the 2nd entry" do
    #   book.import_from_csv('entries.csv')
    #   entry_two = book.entries[1]
    #   check_entry(entry_two,'Bob','555-555-5415','bob@blocmail.com')
    # end
    # it "imports the 3rd entry" do
    #   book.import_from_csv('entries.csv')
    #   entry_three = book.entries[2]
    #   check_entry(entry_three,'Joe','555-555-3660','joe@blocmail.com')
    # end
    # it "imports the 4th entry" do
    #   book.import_from_csv('entries.csv')
    #   entry_four = book.entries[3]
    #   check_entry(entry_four,'Sally','555-555-4646','sally@blocmail.com')
    # end
    # it "imports the 5th entry" do
    #   book.import_from_csv('entries.csv')
    #   entry_five = book.entries[4]
    #   check_entry(entry_five,'Sussie','555-555-2036','sussie@blocmail.com')
    # end

  end

end
