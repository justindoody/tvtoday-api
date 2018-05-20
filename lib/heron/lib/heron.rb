class Heron
  class << self
    SECRETS_BASE_DIR = '/run/secrets/'

    def env
      @env ||= Dir.children(SECRETS_BASE_DIR).map(&:downcase)
    end

    def read_value(key)
      File.read("#{SECRETS_BASE_DIR}#{key}").strip
    end

    def method_missing(method, *args, &block)
      key = method.to_s.downcase
      env.include?(key) ? read_value(key) : super
    end
  end
end
