Product.delete_all
Product.create(title: 'Programming Ruby 1.9',
               description: %{<p>Ruby is the fastest growing and most exciting dynamic language out there. If you need to get working programs delivered fast,  you should add Ruby to your toolbox. </p>},
               image_url: 'ruby.jpg',
               price: 49.95)
Product.create(title: 'Rails Test Prescriptions',
               description: %{<p>Ruby and Rails programs will only survive if you keep them maintainable.</p>},
               image_url: 'rtp.jpg',
               price: 19.95)

User.delete_all
User.create(name: 'dave', password: 'secret', password_confirmation: 'secret')
User.create(name: 'scott', password: 'tiger', password_confirmation: 'tiger')