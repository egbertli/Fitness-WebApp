-- 12/09/2016
-- Edward Lin

create table user_accounts(
    primary key user_id;
    username varchar(50);
    email varchar(50);
    password varchar(50);
    last_location_lat real;
    last_location_long real;
    user_avator_dir varchar(50); -- PATH/user_avator.jpeg
    age integer;
    gender char;
    weight real;
    height real;
    blood_pressure real;
    body_fat_percentage real;
    athlete boolean;
    heart_disease boolean;
    smoke boolean;
    medical_implant boolean;
    preganent boolean;
)

-- uni-directional
create table friends_list (
    foreign key user_id references user_accounts(user_id);
    foreign key friends_list references user_accounts(user_id);
)


---------------------  food  ---------------------------

-- create table food_detail{
--     primary key food_id;
--     foreign key class references classification(cid);
--     food_name varchar(50);
--     energy real;
--     carbohydrates real;
--     saturated_fat real;
--     unsaturated_fat real;
--
--     -- http://www.calorieking.com/foods/calories-in-goose-roasted-goose-with-skin_f-ZmlkPTY4MDg0.html
-- }
--
-- -- class and class name
-- create table food_classes () {
--     primary key class_id;
--     class_name varchar(20);
-- }
--
-- -- different levels of classification
-- create table food_sub_classes () {
--     foreign key class references food_classes(class_id);
--     foreign key sub_class references food_classes(class_id);
-- }
--
-- -- whats in the catagory
-- create table foods_by_class () {
--     foreign key class_id references classification(class_id);
--     foreign key foods references food_detail(food_id);
-- }

---------------------  end food  ---------------------------



---------------------  fitness videos  ---------------------------

create table fintness_video(
    primary key video_id;
    foreign key uploaded_by references user_accounts(user_id);
    foreign key category references fitness_category(cat_id);
    link varchar(200);
    name varchar(20);
    description varchar(200);
    like_num integer;
)

-- can be found by fintness_video
-- users_videos () {
--     foreign key user_id references user_accounts(user_id);
--     link varchar(50);
-- }


create table fitness_categories{
    primary key cat_id;
    category_name varchar(20); --body shapping, losing weight
}


create table fitness_sub_categories{
    foreign key cat_id references fitness_categories(cat_id);
    foreign key sub_cat references user_accounts(user_id);
}


create table videos_by_categories{
    foreign key category references fitness_categories(cat_id);
    foreign key video references user_accounts(user_id);
}


create table fitness_equipment {
    primary key equipment_id;
    foreign key cat_id references fitness_categories(cat_id);
    equipment_name varchar(20);
}

---------------------  end fitness  ---------------------------


create table recipe(
    recipe_name;
    food_require_list;
    steps;
)
