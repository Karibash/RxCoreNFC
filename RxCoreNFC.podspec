Pod::Spec.new do |spec|
  spec.name               = "RxCoreNFC"
  spec.version            = "0.4.0"
  spec.summary            = "Reactive extension for the CoreNFC."
  spec.description        = <<-DESC
  Reactive extension for the CoreNFC.
                            DESC
  spec.homepage           = "https://github.com/Karibash/RxCoreNFC"
  spec.license            = "MIT"
  spec.author             = "Karibash"
  spec.social_media_url   = "https://twitter.com/Karibash"
  spec.platform           = :ios, "11.0"
  spec.source             = { :git => "https://github.com/Karibash/RxCoreNFC.git", :tag => "#{spec.version}" }
  spec.source_files       = "Sources/**/*.{swift}"
  spec.requires_arc       = true
  spec.swift_version      = "5.0"
  spec.frameworks         = "Foundation", "CoreNFC"
  spec.dependency           "RxSwift", "~> 5.0"
  spec.dependency           "RxCocoa", "~> 5.0"
end
