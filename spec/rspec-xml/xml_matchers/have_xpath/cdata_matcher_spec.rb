require 'spec_helper'

describe RSpecXML::XMLMatchers::HaveXPath::CdataMatcher do
  describe '#initialize' do
    it 'should accept an xpath' do
      matcher = subject.class.new(:xpath => 'not a real xpath')
      expect(matcher.send(:xpath)).to eq 'not a real xpath'
    end
  end

  describe '#matches?' do
    # TODO mock out Nokogiri

    it 'should return true if the supplied xml contains the xpath with CDATA' do
      matcher = subject.class.new(:xpath => '//root/hi')
      expect(matcher.matches?(<<EOS
      <root>
          <hi><![CDATA[hello]]></hi>
          <hi>hi</hi>
          <hi>hey</hi>
      </root>
EOS
             )).to be_truthy
    end

    it 'should return false if the supplied xml contains the xpath but not CDATA' do
      matcher = subject.class.new(:xpath => '//hi')
      expect(matcher.matches?('<hi></hi>')).to be_falsey
    end

    it 'should return false if the supplied xml does not contain the xpath' do
      matcher = subject.class.new(:xpath => '//hi')
      expect(matcher.matches?('<no></no>')).to be_falsey
    end

  end

  describe '#failure_message' do
    it 'should turn a message about the xpath not existing with CDATA' do
      subject.stubs(:xpath).returns('xpath')
      expect(subject.failure_message).to eq "expected xpath to contain CDATA"
    end
  end

  describe '#failure_message_when_negated' do
    it 'should turn a message about the xpath existing when it should not' do
      subject.stubs(:xpath).returns('xpath')
      expect(subject.failure_message_when_negated).to eq "expected xpath to not exist with CDATA"
    end
  end

  describe '#description' do
    it 'should return a message describing the text matcher' do
      subject.stubs(:xpath).returns('/expr')
      expect(subject.description).to eq 'have xpath /expr with CDATA'
    end
  end
end
