module ActiveAdmin
  module Views
    # Build a StatusTag
    class StatusTag < ActiveAdmin::Component
      builder_method :status_tag

      def tag_name
        'span'
      end

      def default_class_name
        'status_tag'
      end

      # @method status_tag(status, type = nil, options = {})
      #
      # @param [String] status the status to display. One of the span classes will be an underscored version of the status.
      # @param [Symbol] type type of status. Will become a class of the span. ActiveAdmin provide style for :ok, :warning and :error.
      # @param [Hash] options such as :class, :id and :label to override the default label
      #
      # @return [ActiveAdmin::Views::StatusTag]
      #
      # Examples:
      #   status_tag('In Progress')
      #   # => <span class='status_tag in_progress'>In Progress</span>
      #
      #   status_tag('active', :ok)
      #   # => <span class='status_tag active ok'>Active</span>
      #
      #   status_tag('active', :ok, class: 'important', id: 'status_123', label: 'on')
      #   # => <span class='status_tag active ok important' id='status_123'>on</span>
      #
      def build(*args)
        options = args.extract_options!
        status = args[0]
        type = args[1]
        label = options.delete(:label)
        classes = options.delete(:class)
        status = convert_to_boolean_status(status) 

        content = label || status.titleize if status

        super(content, options)

        add_class(status_to_class(status)) if status
        add_class(type.to_s) if type
        add_class(classes) if classes
      end

      protected

      def convert_to_boolean_status(status)
        if status == 'true'
          'Yes'
        elsif ['false', nil].include?(status)
          'No'
        else
          status
        end
      end

      def status_to_class(status)
        status.titleize.gsub(/\s/, '').underscore
      end
    end
  end
end
