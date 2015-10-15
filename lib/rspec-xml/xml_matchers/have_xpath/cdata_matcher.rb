module RSpecXML
  module XMLMatchers
    class HaveXPath

      private

      class CdataMatcher

        def initialize(options={})
          self.xpath = options[:xpath]
        end

        def matches?(xml)
          ::Nokogiri::XML(xml).xpath(xpath).any? { |x| x.child.cdata? if x.child }
        end

        def description
          "have xpath #{xpath} with CDATA"
        end

        def failure_message
          "expected #{xpath} to contain CDATA"
        end

        def failure_message_when_negated
          "expected #{xpath} to not exist with CDATA"
        end

        private

        attr_accessor :xpath
      end
    end
  end
end
