#!/usr/bin/env ruby
# coding: utf-8

class Logger

	def Logger.trace(*parameters)
		print(Time.now().strftime('%Y-%m-%d %H:%M:%S.%L'), ' [TRACE] ', *parameters, "\n")
	end

end

class AbstractTask

	def initialize()
		Logger.trace('<AbstractTask.initialize()>')
	end

	def invoke()
		raise('ASSERTION FAILURE! pure virtual function call!')
	end

end

class Function1 < AbstractTask

	def initialize()
		super()
		Logger.trace('<', self.class, '.initialize()>')
	end

	def invoke()
		Logger.trace('<', self.class, '.invoke()>')
	end

end

class Function2 < AbstractTask

	def initialize()
		super()
		Logger.trace('<', self.class, '.initialize()>')
	end

	def invoke()
		Logger.trace('<', self.class, '.invoke()>')
	end

end

class Loader

	def initialize()
	end

	def configure(path)
	end

	def load(context)
		f = Function1.new()
		return f
	end

end

class Application

	def run(request)
		loader = Loader.new()
		f = loader.load(nil)
		f.invoke()
		Logger.trace('このインスタンスは Function1 である => ', f.is_a?(Function1))
		Logger.trace('このインスタンスは Function2 である => ', f.is_a?(Function2))
	end

end

def main(argv)
	app = Application.new()
	app.run(argv[0])
end

main(ARGV)
