CatBook powered by IronHack
===========================

Because cats, as social beings, also deserve a place to share their experiences.

Step by step implementation
---------------------------

1. ``rails new catbook``
2. Use rspec instead of minitest - [Rspec](https://github.com/rspec/rspec-rails)
3. Use factory_girl - [FactoryGirl](https://github.com/thoughtbot/factory_girl_rails)
4. Use Postgres as default database - [Configuring a Database - Rails Guides](http://guides.rubyonrails.org/configuring.html#configuring-a-database)
5. Basic cat model ``rails generate model cat``
6. Bower and boostrap - [Bower](http://bower.io/)
7. Create basic scaffold for listing, editing and showing cats
  - Security pitfalls are on purpose included here in order the students to find them
  - Included kaminari pagination - [Kaminari](https://github.com/amatsuda/kaminari)
8. Introduce sightly advanced association ``FollowerRelation`` - [FrontMatter rails tutorial](https://www.railstutorial.org/book/frontmatter)
9. Do 'heavy' queries to render followers in cats#show and cats#index
10. Generate rake task to seed followers ``rails g task catbook seed_follower_relations`` (Note: Could have been also done in the seeds file? Is is better like this?)

References
----------
- Inspiration resources
  * Sad Cat Diary - [youtube video](https://www.youtube.com/watch?v=PKffm2uI4dk)
  * Dear Kitten - [youtube video](https://www.youtube.com/watch?v=G4Sn91t1V4g)
  * Talking animals - [youtube page](https://www.youtube.com/user/klaatu42)
- Useful resources
  * Mockup images of kitties - [placekitten](http://placekitten.com/)
  * The Cat API - [The Cat Api](http://thecatapi.com/)
  * HTTP Status Cats API - [HTTP Status Cats API](http://httpcats.herokuapp.com/)
