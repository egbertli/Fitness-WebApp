/*
    Table for stroing users' informatioin 
    @author Edward Lin/ modifed by Egbert Li
    14/9/16
*/    
create table if not exists `user_accounts` (
    user_id int unsigned not null primary key auto_increment,
    username varchar(50) not null,
    email varchar(50) not null,
    password varchar(16) not null,
    gender char(4)  default '-',
    last_location_lat double(7,6) default '0.00000',
    last_location_long double(7,6) default '0.00000',
    user_avator_dir varchar(50),   /* PATH/user_avator.jpeg */
    age tinyint unsigned  default '20',
    weight double(3,2),
    height double(3,2),
    blood_pressure double(3,2),
    body_fat_percentage double(3,2),
    athlete int unsigned,
    heart_disease int unsigned,
    smoke int unsigned,
    medical_implant int unsigned
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



/*
    Table for users' friend list
    @author Edward Lin/ modifed by Egbert Li
    14/9/16
*/
create table if not exists  `friends_list` (
    friend_list_id int unsigned not null primary key auto_increment, 
    f_user_id int unsigned,
    friend_id int unsigned,
    foreign key( f_user_id ) references user_accounts( user_id ),  /* FK to user_accounts user_id attribute */
    foreign key (friend_id) references user_accounts(user_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


---------------------  food  ---------------------------

/* 
    Table for food class and class name
    @author Edward Lin/ modifed by Egbert Li
    14/9/16
*/
create table if not exists  `food_classes` ( 
    class_id int unsigned not null primary key auto_increment,
    class_name varchar(20) not null default '-'
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*
    Table for storing food detail information
    @author Edward Lin/ modifed by Egbert Li
    14/9/16
*/
create table if not exists  `food_detail`(
    food_id int unsigned not null primary key auto_increment, 
    f_class int unsigned,
    food_name varchar(50),
    energy double(6,3),
    carbohydrates double(6,3),
    saturated_fat double(6,3),
    unsaturated_fat double(6,3),
    gluten double(6,3),
    foreign key (f_class) references food_classes(class_id) 
    -- http://www.calorieking.com/foods/calories-in-goose-roasted-goose-with-skin_f-ZmlkPTY4MDg0.html
)ENGINE=InnoDB DEFAULT CHARSET=utf8;



/*
    Table for storing different levels of classification
    @author Edward Lin/ modifed by Egbert Li
    14/9/16
*/
create table if not exists  `food_sub_classes` (
    food_sub_class_id int unsigned not null primary key auto_increment,
    class int unsigned,
    sub_class int unsigned,
    foreign key (class) references food_classes(class_id),
    foreign key (sub_class) references food_classes(class_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*
    Table for storing food category-whats in the catagory
    @author Edward Lin/ modifed by Egbert Li
    14/9/16
*/
create table if not exists  `foods_by_class` (
    food_by_class_id int unsigned not null primary key auto_increment,
    f_class_id int unsigned, 
    foods int unsigned,
    foreign key (f_class_id) references food_classes(class_id),
    foreign key (foods) references food_detail(food_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


---------------------  fitness videos  ---------------------------

/*
    Table for storing fitness category 
    @author Edward Lin/ modifed by Egbert Li
    14/9/16
*/
create table if not exists  `fitness_categories` (
    cat_id int unsigned not null primary key auto_increment,
    category_name varchar(40)  /* body shapping, losing weight */
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


/*
    Table for storing fitness video
    @author Edward Lin/ modifed by Egbert Li
    14/9/16
*/
create table if not exists `fintness_video` (
    video_id int unsigned not null primary key auto_increment,
    video_name varchar(255) not null default "-",
    uploaded_by int unsigned not null,
    category int unsigned not null,
    foreign key ( uploaded_by ) references user_accounts(user_id),  /* who uploaded video */
    foreign key ( category ) references fitness_categories(cat_id),
    link varchar(200),  /* later need write regx to check validation of link */
    description varchar(255),
    like_num int unsigned default '0'
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


/*
    Table for storing fitness sub-category 
    @author Edward Lin/ modifed by Egbert Li
    14/9/16
*/
create table if not exists  `fitness_sub_categories` (
    fit_sub_cat_id int unsigned not null primary key auto_increment,
    fit_cat_id int unsigned,
    fit_sub_cat int unsigned, 
    foreign key ( fit_cat_id ) references fitness_categories(cat_id),
    foreign key ( fit_sub_cat ) references user_accounts(user_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*
    Table for storing fitness videos by fitness category
    @author Edward Lin/ modifed by Egbert Li
    14/9/16
*/
create table if not exists  `videos_by_categories`(
    video_cate_id int unsigned not null primary key auto_increment,
    category int unsigned not null,
    video_upload_user int unsigned not null,
    foreign key (category) references fitness_categories(cat_id),
    foreign key (video_upload_user) references user_accounts(user_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*
    Table for storing fitness equipment by fitness category
    @author Edward Lin/ modifed by Egbert Li
    14/9/16
*/
create table if not exists `fitness_equipment` ( 
    equipment_id int unsigned primary key auto_increment, 
    fit_cat_id int unsigned not null,
    foreign key (fit_cat_id) references fitness_categories(cat_id),
    equipment_name varchar(20)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- can be found by fintness_video
-- users_videos () {
--     foreign key user_id references user_accounts(user_id);
--     link varchar(50);
-- }

---------------------  meal recipe  ---------------------------
/*
    Table for storing meal recipe information 
    @author Edward Lin/ modifed by Egbert Li
    14/9/16
*/
create table if not exists `recipe` (
    recipe_id int unsigned primary key not null auto_increment,
    recipe_name varchar(20),
    required_food int unsigned,
    foreign key (required_food) references food_detail(food_id), 
    recipe_description varchar(255) default 'please wirte your secret recipe description.'
)ENGINE=InnoDB DEFAULT CHARSET=utf8;



/*
    Insert dummy data for test 
    @author Egbert Li
    21/9/16
*/ 
insert into user_accounts (user_id, username, email, password, gender)
values
(1, 'egbert_li', 'egbert_li@gmail.com', '1234567', 'Male'),
(2, 'egbert_zhang', 'egbert_zhang@gmail.com', '1234567', 'Male'),
(3, 'egbert_wang', 'egbert_wang@gmail.com', '1234567', 'Male'),
(4, 'egbert_he', 'egbert_he@gmail.com', '1234567', 'Male')
;

/*
	Insert fitness categores in system database 
	@author Egbert Li
	21/9/16
*/
insert into fitness_categories(cat_id, category_name)
values
(1, 'Balance/Agility'),
(2, 'Barre'),
(3, 'Hiit'),
(4, 'Cardiovascular'),
(5, 'Kettlebell'),
(6, 'Low Impact'),
(7, 'Pilates'),
(8, 'Plyometric'),
(9, 'Strength Training'),
(10, 'Toning'),
(11, 'Warm Up/Cool Down'),
(12, 'Yoga/Stretching/Flexibility')
;


/*
	Insert fitness videos in system database 
	@author Egbert Li
	21/9/16
*/
insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(1, 'Brutal Low Impact Workout - Advanced Functional Strength, Balance and Core Workou', 1, 1, '<iframe width="560" height="315" src="https://www.youtube.com/embed/XNs8GNDlJgM" frameborder="0" allowfullscreen></iframe>'),

(2, 'Brutal Anaerobic Threshold HIIT - Fat Burning HIIT Cardio', 1, 1, '<iframe width="560" height="315" src="https://www.youtube.com/embed/o8wQ9w9yfDo" frameborder="0" allowfullscreen></iframe>'),

(3, 'Low Impact Cardio and Toning Workout for Beginners', 1, 1, '<iframe width="560" height="315" src="https://www.youtube.com/embed/GjAhM651ZPU" frameborder="0" allowfullscreen></iframe>'),

(4, 'When I Say Jump HIIT Cardio Workout Round 2 - 28 Min High Intensity Interval Training', 1, 1, '<iframe width="560" height="315" src="https://www.youtube.com/embed/j3cRRCTREu0" frameborder="0" allowfullscreen></iframe>'),

(5, 'When I Say Jump HIIT - Total Body Toning and HIIT Cardio Workout', 1, 1, '<iframe width="560" height="315" src="https://www.youtube.com/embed/dlOayNdj_P0" frameborder="0" allowfullscreen></iframe>'),

(6, 'Quiet Cardio Workout - Low Impact, Apartment Cardio Workout', 1, 1, '<iframe width="560" height="315" src="https://www.youtube.com/embed/YaJryQEsT94" frameborder="0" allowfullscreen></iframe>'),

(7, 'Interval Training Workout - Toning and Cardio Boot Camp', 1, 1, '<iframe width="560" height="315" src="https://www.youtube.com/embed/D9BC884dIDg" frameborder="0" allowfullscreen></iframe>'),

(8, '32 Minute Bodyweight Workout - Total Body Toning & Functional Strength Training Exercises', 1, 1, '<iframe width="560" height="315" src="https://www.youtube.com/embed/U7K6yFOjsJI" frameborder="0" allowfullscreen></iframe>'),

(9, 'Sports Endurance Workout - Stamina, Speed, and Agility Workout', 1, 1, '<iframe width="560" height="315" src="https://www.youtube.com/embed/5uVaKjtJHN8" frameborder="0" allowfullscreen></iframe>'),

(10, 'Volleyball Workout Video - Volleyball Exercises for Conditioning & Strength', 1, 1, '<iframe width="560" height="315" src="https://www.youtube.com/embed/wEe_Zkcp7HY" frameborder="0" allowfullscreen></iframe>'),

(11, 'Agility Exercises to Increase Balance & Muscle Tone - Advanced Balance Workout', 1, 1, '<iframe width="560" height="315" src="https://www.youtube.com/embed/7pwSKcFnSHs" frameborder="0" allowfullscreen></iframe>'),

(12, 'Beginner Exercises for Balance - 15 Minute Beginner Balance Workout', 1, 1, '<iframe width="560" height="315" src="https://www.youtube.com/embed/6PIVgUe6z3E" frameborder="0" allowfullscreen></iframe>'),

(13, '27 Minute Total Body Medicine Ball Workout - Medicine Ball Exercises', 1, 1, '<iframe width="560" height="315" src="https://www.youtube.com/embed/nV3A5F28AB8" frameborder="0" allowfullscreen></iframe>'),

(14, 'Standing Abs Exercises - 10 Minute Standing Abs Workout', 1, 1, '<iframe width="560" height="315" src="https://www.youtube.com/embed/08Bi8hMdwa4" frameborder="0" allowfullscreen></iframe>'),

(15, 'Total Body Exercise Ball Workout - 10 Minute Physioball Routine', 1, 1, '<iframe width="560" height="315" src="https://www.youtube.com/embed/ChRgTA2toC0" frameborder="0" allowfullscreen></iframe>'),

(16, 'Fitness Blender Golf Workout - Strength, Balance & Flexibility Exercises for Golfers', 1, 1, '<iframe width="560" height="315" src="https://www.youtube.com/embed/5F8iPHvVq6E" frameborder="0" allowfullscreen></iframe>'),

(17, '30 Minute Ski Conditioning Workout - Strength and Cardio Training', 1, 1, '<iframe width="560" height="315" src="https://www.youtube.com/embed/pKnP88kWTKA" frameborder="0" allowfullscreen></iframe>'),

(18, '28 Minute Total Body Slosh Pipe Workout - Slosh Tube Exercises for Strength & Toning', 1, 1, '<iframe width="560" height="315" src="https://www.youtube.com/embed/8fvz1LnPbQQ" frameborder="0" allowfullscreen></iframe>'),

(19, '28 Minute Snowboard Workout - Conditioning Workout Routine', 1, 1, '<iframe width="560" height="315" src="https://www.youtube.com/embed/SfekYZS00-Y" frameborder="0" allowfullscreen></iframe>'),

(20, 'Butt & Thigh Pilates Barre Blend', 1, 2, '<iframe width="560" height="315" src="https://www.youtube.com/embed/9_Wyf2UQDqc" frameborder="0" allowfullscreen></iframe>'),

(21, 'Leg Slimming Pilates Butt and Thigh Workout to Lift Glutes & Tone Thighs', 1, 2, '<iframe width="560" height="315" src="https://www.youtube.com/embed/Womx4TM6p3A" frameborder="0" allowfullscreen></iframe>'),

(22, '10 Minute Abs Workout - At Home Abs and Obliques Exercises with No Equipment', 1, 2, '<iframe width="560" height="315" src="https://www.youtube.com/embed/qniTvaPXESA" frameborder="0" allowfullscreen></iframe>'),

(23, 'No Equipment Upper Body Workout for Great Arms, Shoulders and Upper Back', 1, 2, '<iframe width="560" height="315" src="https://www.youtube.com/embed/CRGrcSDhynQ" frameborder="0" allowfullscreen></iframe>'),

(24, 'Pilates Butt and Thigh Burnout - Squat Free Workout for a Lifted, Round Butt and Toned Thighs', 1, 2, '<iframe width="560" height="315" src="https://www.youtube.com/embed/JgJTg-Vr_YI" frameborder="0" allowfullscreen></iframe>'),

(25, 'Low Impact Abs, Butt and Thighs Workout - Feel Good Total Body Sculpt and Stretch', 1, 2, '<iframe width="560" height="315" src="https://www.youtube.com/embed/qULT-kdDEC4" frameborder="0" allowfullscreen></iframe>'),

(26,'Butt & Thigh Barre Workout for Long Lean Legs - Beach Barre Workout', 1, 2, '<iframe width="560" height="315" src="https://www.youtube.com/embed/SPEMWR3m0eA" frameborder="0" allowfullscreen></iframe>'),

(27, 'At Home Total Body Barre Workout - 15 Minute Barre Video', 1, 2, '<iframe width="560" height="315" src="https://www.youtube.com/embed/MneYxp4fqw0" frameborder="0" allowfullscreen></iframe>'),

(28, 'No Squat Leg Workout - Squat Free Butt & Thigh Workout', 1, 2, '<iframe width="560" height="315" src="https://www.youtube.com/embed/EmA1iWrsU4g" frameborder="0" allowfullscreen></iframe>'),

(29, 'Home Upper Body Workout without Weights - Bodyweight Workout for Beginners', 1, 2, '<iframe width="560" height="315" src="https://www.youtube.com/embed/MrpGbulGprA" frameborder="0" allowfullscreen></iframe>'),
(30, 'Barre Workout for Butt and Thighs - Workout for Lean Legs and Toned Butt', 1, 2, '<iframe width="560" height="315" src="https://www.youtube.com/embed/514W-RB7Xiw" frameborder="0" allowfullscreen></iframe>'),
(31, 'Booty Blaster - Killer 5 Minute Butt and Thigh Workout Challenge',  1, 2, '<iframe width="560" height="315" src="https://www.youtube.com/embed/Ux4tzO6Uaxk" frameborder="0" allowfullscreen></iframe>')
;


/*
	Insert fitness videos in system database 
	@author Cherry Zhao
	22/9/16
*/
insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(32, '3 Day Flexibility Challenge Day 3: Static Stretches for Flexibility & Range of Motion', 1, 12, '<iframe width="560" height="315" src="https://www.youtube.com/embed/eV7hkrp9nII" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(33, '3 Day Flexibility Challenge Day 2: Pilates Yoga Blend for Flexibility and Toning', 1, 12, '<iframe width="560" height="315" src="https://www.youtube.com/embed/xCsETuMdp2w" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(34, '3 Day Flexibility Challenge Day 1: Fluid Full Body Stretches for Flexibility', 1, 12, '<iframe width="560" height="315" src="https://www.youtube.com/embed/wCsvZwK_e_8" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(35, 'Relaxing Total Body Stretching Workout for Stress Relief and Better Sleep', 1, 12, '<iframe width="560" height="315" src="https://www.youtube.com/embed/tf77HZVDI80" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(36, 'Chill Out! Stretching Yoga Workout for Flexibility and Calm - Warm Up or Cool Down Workout', 1, 12, '<iframe width="560" height="315" src="https://www.youtube.com/embed/32bzgV0lMRE" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(37, 'Relaxing Stretching Workout for Flexibility and Stress Relief - Full Body Yoga Pilates Blend', 1, 12, '<iframe width="560" height="315" src="https://www.youtube.com/embed/7h_Pn7NyJ0k" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(38, 'Relaxing Stretching Workout for Stiff Muscles & Stress Relief - Easy Stretches to Do at Work', 1, 12, '<iframe width="560" height="315" src="https://www.youtube.com/embed/a9WC_eLmP30" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(39, 'Fluid Yoga Stretches for Flexibility and Strength', 1, 12, '<iframe width="560" height="315" src="https://www.youtube.com/embed/o9XOgcw0eBo" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(40, 'Quick and Easy Pilates Toning and Flexibility Workout', 1, 12, '<iframe width="560" height="315" src="https://www.youtube.com/embed/0PXRL5RhNok" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(41, 'Beginner Abs, Obliques and Lower Back Workout - Stretch and Tone for Core Stability and Back Health', 1, 12, '<iframe width="560" height="315" src="https://www.youtube.com/embed/7XyaQNZJv4s" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(42, 'Cardio Warm Up Butt and Thigh Workout - Warm Up Workout with Lower Body Exercises', 1, 11, '<iframe width="560" height="315" src="https://www.youtube.com/embed/yoP-NeGtNMI" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(43, 'Total Body Cooldown - Compound Movements for a Total Body Stretch', 1, 11, '<iframe width="560" height="315" src="https://www.youtube.com/embed/WK1t1-d2t1Y" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(44, 'Fun Low Impact Cardio Workout for Beginners - Total Body Exercises for Beginners', 1, 11, '<iframe width="560" height="315" src="https://www.youtube.com/embed/zfgEwSvatqY" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(45, 'Wake Up Call Cardio Workout - Calorie Burning Warm Up Cardio for Energy', 1, 11, '<iframe width="560" height="315" src="https://www.youtube.com/embed/Ie4ZTuMh_K0" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(46, 'Calorie Burning Cardio Warm Up - Total Body Warm Up Workout', 1, 11, '<iframe width="560" height="315" src="https://www.youtube.com/embed/iYFKB5fgqtQ" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(47, 'Get Moving! Cardio Warm Up Workout - Easy Calorie Burning Warm Up Cardio', 1, 11, '<iframe width="560" height="315" src="https://www.youtube.com/embed/ns8JUSLod1I" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(48, 'Lake Yoga Workout - Fluid Yoga Stretches for Flexibility, Toning & Stress Relief - Cool Down Workout', 1, 11, '<iframe width="560" height="315" src="https://www.youtube.com/embed/jkkxMVDogBM" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(49, 'Quick Yoga Cool Down and Stretch - Cool Down Stretches', 1, 11, '<iframe width="560" height="315" src="https://www.youtube.com/embed/FAKaKgmn76E" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(50, 'Total Body Warm Up Cardio - 5 Minute Warm Up Worko', 1, 11, '<iframe width="560" height="315" src="https://www.youtube.com/embed/GCzecFateXc" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(51, 'Lower Body Active Stretching Routine - Low Impact Workout to Tone and Stretch', 1, 11, '<iframe width="560" height="315" src="https://www.youtube.com/embed/NNkH4vDaVIo" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(52, "Cardio and Upper Body Toning Workout - Fitness Blender's No Equipment Cardio and Upper Body Workout", 1, 10, '<iframe width="560" height="315" src="https://www.youtube.com/embed/ie8udQScmvU" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(53, "100 Rep Abs and Obliques Workout - Fitness Blender's 5 Minute Abs Workout Routine", 1, 10, '<iframe width="560" height="315" src="https://www.youtube.com/embed/Po_pWGk3wYc" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(54, 'Fat Blasting At Home Cardio Kickboxing Workout Video by Fitness Blender', 1, 10, '<iframe width="560" height="315" src="https://www.youtube.com/embed/TYGHc9mdH6M" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(55, '6 Pack or Bust Abs and Obliques Workout - 6 Pack Abs Workout', 1, 10, '<iframe width="560" height="315" src="https://www.youtube.com/embed/aqqwZ_leAMA" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(56, 'HIIT Cardio and Abs Workout - 30 Minute At Home HIIT Workout with Abs Exercises', 1, 10, '<iframe width="560" height="315" src="https://www.youtube.com/embed/pNZe01hqMW8" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(57, 'Comprehensive Total Body HIIT Cardio and Core Workout', 1, 10, '<iframe width="560" height="315" src="https://www.youtube.com/embed/NGhZUc00YhE" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(58, "Double Kettlebell Workout - Fitness Blender's Calorie Blasting Kettlebell Training", 1, 10, '<iframe width="560" height="315" src="https://www.youtube.com/embed/_hK_FID5NNY" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(59, "20 Minute Total Body Strength and Cardio Workout - Fitness Blender's Total Body Toning Workout", 1, 10, '<iframe width="560" height="315" src="https://www.youtube.com/embed/gMGF88XMh2s" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(60, 'Best Workouts to Lose Belly Fat Quickly - Cardio Abs and Obliques Workout', 1, 10, '<iframe width="560" height="315" src="https://www.youtube.com/embed/M_RjP2TB8c8" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(61, 'Squat Free Butt & Thigh Workout - No Squat Leg Workout by FitnessBlender.com', 1, 10, '<iframe width="560" height="315" src="https://www.youtube.com/embed/EmA1iWrsU4g" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(62, '1000 Calorie Workout - HIIT Cardio, Strength, Kickboxing and Abs Workout to Burn 1000 Calories', 1, 9, '<iframe width="560" height="315" src="https://www.youtube.com/embed/ubT6qNnUmQw" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(63, 'Total Body Boot Camp Workout for Lean Muscles - Work for What You Want', 1, 9, '<iframe width="560" height="315" src="https://www.youtube.com/embed/SUkN6IbWzRc" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(64, "Kelli's Booty Workout - 32 Minute Ultimate Butt and Thigh Workout for a Round Lifted Butt", 1, 9, '<iframe width="560" height="315" src="https://www.youtube.com/embed/jkDb-1L47x8" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(65, 'Total Body Strength Barbell Workout - Dumbbell or Barbell Exercises for Strength', 1, 9, '<iframe width="560" height="315" src="https://www.youtube.com/embed/MaFkoVu59hY" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(66, 'Upper Body Strength and Cardio Workout - 27 Minute Upper Body Superset Workout', 1, 9, '<iframe width="560" height="315" src="https://www.youtube.com/embed/PWSgCYC4UI0" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(67, 'Advanced Abs and Core for Strength - Abdominal Strength Training', 1, 9, '<iframe width="560" height="315" src="https://www.youtube.com/embed/d4CZXqA45nA" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(68, 'Quick and Fearless Kettlebell Cardio Workout - Ultimate Fat Burn Workout for the Entire Body', 1, 9, '<iframe width="560" height="315" src="https://www.youtube.com/embed/B6k4jH_qLUY" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(69, 'Happy, Healthy, Strong Total Body Boot Camp -- Strength and Cardio Tabata Workout', 1, 9, '<iframe width="560" height="315" src="https://www.youtube.com/embed/PU1NL-S9-NY" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(70, 'Chest and Back Superset Workout - At Home Dumbbell Workout for Strength and Size', 1, 9, '<iframe width="560" height="315" src="https://www.youtube.com/embed/5p6F8sA0uRo" frameborder="0" allowfullscreen></iframe>');

insert into fintness_video(video_id, video_name, uploaded_by, category, link)
values
(71, 'Total Body Strength Training & Bodyweight Cardio Intervals - Sore Today Strong Tomorrow', 1, 9, '<iframe width="560" height="315" src="https://www.youtube.com/embed/Cc02cDOHWrY" frameborder="0" allowfullscreen></iframe>');


