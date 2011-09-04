Product.delete_all
Product.create(title: 'Programming Ruby 1.9',
               description: %{<p>Ruby is the fastest growing and most exciting dynamic language out there. If you need to get working programs delivered fast,  you should add Ruby to your toolbox. </p>},
               image_url: 'http://fastcache.gawkerassets.com/assets/images/4/2011/09/xsmall_quantum_01.jpg',
               price: 49.95)
Product.create(title: 'Ruby for the .net developer',
               description: %{<p>You wanna leave the Micro$oft ecosystem. Here's how.</p>},
               image_url: 'http://fastcache.gawkerassets.com/assets/images/4/2011/09/xsmall_quantum_01.jpg',
               price: 49.95)