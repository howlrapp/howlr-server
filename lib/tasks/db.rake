namespace :db do
  task populate: :environment do
    EventCategory.find_or_create_by(uuid: "0a98b027-5d22-4146-a8f0-aced4887d485").update({
      "uuid": "0a98b027-5d22-4146-a8f0-aced4887d485",
      "label": "Convention",
      "created_at": "2021-08-04 17:31:08 UTC",
      "updated_at": "2022-02-20 19:32:45 UTC",
      "system": true
    })
    EventCategory.find_or_create_by(uuid: "3262c0b5-5113-48e4-a537-a886e69011cb").update({
      "uuid": "3262c0b5-5113-48e4-a537-a886e69011cb",
      "label": "Sport",
      "created_at": "2020-10-29 17:49:37 UTC",
      "updated_at": "2020-10-29 17:49:37 UTC",
      "system": false
    })
    EventCategory.find_or_create_by(uuid: "399efce9-823a-49a5-8af3-5793dc68a819").update({
      "uuid": "399efce9-823a-49a5-8af3-5793dc68a819",
      "label": "Movie",
      "created_at": "2020-10-29 17:48:48 UTC",
      "updated_at": "2020-10-29 17:48:48 UTC",
      "system": false
    })
    EventCategory.find_or_create_by(uuid: "94b13419-dc0e-4ba8-9305-f752f8ae308c").update({
      "uuid": "94b13419-dc0e-4ba8-9305-f752f8ae308c",
      "label": "Dining",
      "created_at": "2020-10-29 17:48:28 UTC",
      "updated_at": "2020-10-29 17:48:28 UTC",
      "system": false
    })
    EventCategory.find_or_create_by(uuid: "a302e039-22d9-491c-80c7-14650a6991d3").update({
      "uuid": "a302e039-22d9-491c-80c7-14650a6991d3",
      "label": "Walk",
      "created_at": "2020-10-29 17:49:56 UTC",
      "updated_at": "2020-10-29 17:49:56 UTC",
      "system": false
    })
    EventCategory.find_or_create_by(uuid: "aba5335c-2cbd-4ec9-9be0-d3152bd331fb").update({
      "uuid": "aba5335c-2cbd-4ec9-9be0-d3152bd331fb",
      "label": "Protest",
      "created_at": "2020-10-29 17:50:09 UTC",
      "updated_at": "2020-10-29 17:50:09 UTC",
      "system": false
    })
    EventCategory.find_or_create_by(uuid: "ed9d6702-ac96-4b2b-b54c-ecbb36e2f647").update({
      "uuid": "ed9d6702-ac96-4b2b-b54c-ecbb36e2f647",
      "label": "Online",
      "created_at": "2020-11-02 12:22:44 UTC",
      "updated_at": "2020-11-02 12:22:44 UTC",
      "system": false
    })
    EventCategory.find_or_create_by(uuid: "ffb1f79a-0bb9-4875-a280-912cd60bad0d").update({
      "uuid": "ffb1f79a-0bb9-4875-a280-912cd60bad0d",
      "label": "Party",
      "created_at": "2021-07-31 19:39:18 UTC",
      "updated_at": "2021-07-31 19:39:18 UTC",
      "system": false
    })
    Gender.find_or_create_by(uuid: "0f41d3d4-5b65-4082-9910-b584414ca502").update({
      "name": "trans_man",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-16 15:19:42 UTC",
      "label": "Trans man",
      "uuid": "0f41d3d4-5b65-4082-9910-b584414ca502",
      "order": 2
    })
    Gender.find_or_create_by(uuid: "1436cc74-025b-4f25-b07c-92b01dc3ed41").update({
      "name": "bigender",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-16 15:19:42 UTC",
      "label": "Bigender",
      "uuid": "1436cc74-025b-4f25-b07c-92b01dc3ed41",
      "order": 15
    })
    Gender.find_or_create_by(uuid: "27d858da-c749-433a-904b-6104477b7736").update({
      "name": "man",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-20 17:17:04 UTC",
      "label": "Male",
      "uuid": "27d858da-c749-433a-904b-6104477b7736",
      "order": 1
    })
    Gender.find_or_create_by(uuid: "2d66aa0e-6fc8-4942-ba38-b96556ca5979").update({
      "name": "transgender",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-16 15:19:42 UTC",
      "label": "Transgender",
      "uuid": "2d66aa0e-6fc8-4942-ba38-b96556ca5979",
      "order": 7
    })
    Gender.find_or_create_by(uuid: "30a49418-6382-4251-b7bd-7ee0d81c0572").update({
      "name": "agender",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-16 15:19:42 UTC",
      "label": "Agender",
      "uuid": "30a49418-6382-4251-b7bd-7ee0d81c0572",
      "order": 13
    })
    Gender.find_or_create_by(uuid: "3f613fd6-43af-421e-a273-ee9b6088236f").update({
      "name": "trans_woman",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-16 15:19:42 UTC",
      "label": "Trans woman",
      "uuid": "3f613fd6-43af-421e-a273-ee9b6088236f",
      "order": 3
    })
    Gender.find_or_create_by(uuid: "4892df17-2d99-4eae-8be5-95080c054ef1").update({
      "name": "transfeminine",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-16 15:19:42 UTC",
      "label": "Transfeminine",
      "uuid": "4892df17-2d99-4eae-8be5-95080c054ef1",
      "order": 6
    })
    Gender.find_or_create_by(uuid: "699fba3e-c6b8-4423-994f-51615d3102ca").update({
      "name": "woman",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-20 17:17:01 UTC",
      "label": "Female",
      "uuid": "699fba3e-c6b8-4423-994f-51615d3102ca",
      "order": 0
    })
    Gender.find_or_create_by(uuid: "82286950-b191-4a9c-b07c-cb2c4bd7a541").update({
      "name": "cis_woman",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-16 15:19:42 UTC",
      "label": "Cis-woman",
      "uuid": "82286950-b191-4a9c-b07c-cb2c4bd7a541",
      "order": 5
    })
    Gender.find_or_create_by(uuid: "838863e1-3366-4d4c-932f-63dc43645ac1").update({
      "name": "other",
      "created_at": "2020-11-02 12:25:40 UTC",
      "updated_at": "2020-11-02 12:25:40 UTC",
      "label": "Other",
      "uuid": "838863e1-3366-4d4c-932f-63dc43645ac1",
      "order": 19
    })
    Gender.find_or_create_by(uuid: "869916c2-628e-4a45-ae38-3136fbcd4928").update({
      "name": "non_binary",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-16 15:19:42 UTC",
      "label": "Non binary",
      "uuid": "869916c2-628e-4a45-ae38-3136fbcd4928",
      "order": 10
    })
    Gender.find_or_create_by(uuid: "90443d8c-4fc3-4757-b328-8115bb0ebf18").update({
      "name": "pangender",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-16 15:19:42 UTC",
      "label": "Pangender",
      "uuid": "90443d8c-4fc3-4757-b328-8115bb0ebf18",
      "order": 17
    })
    Gender.find_or_create_by(uuid: "9985de93-97a7-4083-87e8-9f90a1ebc9d4").update({
      "name": "androgynous",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-16 15:19:42 UTC",
      "label": "Androgynous",
      "uuid": "9985de93-97a7-4083-87e8-9f90a1ebc9d4",
      "order": 14
    })
    Gender.find_or_create_by(uuid: "9f3ed71a-22a4-4e70-8adf-7bd6a992f0d5").update({
      "name": "genderfluid",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-16 15:19:42 UTC",
      "label": "Genderfluid",
      "uuid": "9f3ed71a-22a4-4e70-8adf-7bd6a992f0d5",
      "order": 11
    })
    Gender.find_or_create_by(uuid: "a6b6bf99-3b08-4334-b6f2-45c31687d207").update({
      "name": "transmasculine",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-16 15:19:42 UTC",
      "label": "Transmasculine",
      "uuid": "a6b6bf99-3b08-4334-b6f2-45c31687d207",
      "order": 8
    })
    Gender.find_or_create_by(uuid: "bf2efb86-d2b9-43ea-8554-8587d18dd1e8").update({
      "name": "cis_man",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-16 15:19:42 UTC",
      "label": "Cis-man",
      "uuid": "bf2efb86-d2b9-43ea-8554-8587d18dd1e8",
      "order": 4
    })
    Gender.find_or_create_by(uuid: "dacd3c8e-9f61-4903-8b3d-8fbc0ec2bea9").update({
      "name": "gender_nonconforming",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-16 15:19:42 UTC",
      "label": "Gender nonconforming",
      "uuid": "dacd3c8e-9f61-4903-8b3d-8fbc0ec2bea9",
      "order": 9
    })
    Gender.find_or_create_by(uuid: "f1e9ee4c-d28d-486f-a5e8-721235eb279b").update({
      "name": "genderqueer",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-16 15:19:42 UTC",
      "label": "Genderqueer",
      "uuid": "f1e9ee4c-d28d-486f-a5e8-721235eb279b",
      "order": 12
    })
    GroupCategory.find_or_create_by(uuid: "72aed10d-5c37-4117-8b35-8a82d6bec068").update({
      "uuid": "72aed10d-5c37-4117-8b35-8a82d6bec068",
      "label": "Kinks",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2021-08-04 22:01:17 UTC",
      "order": 2
    })
    GroupCategory.find_or_create_by(uuid: "f5d78fb9-d803-4866-a9e0-afc6da08ffaa").update({
      "uuid": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa",
      "label": "General",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2021-11-07 16:21:00 UTC",
      "order": 1
    })
    Group.find_or_create_by(uuid: "001700b4-3c67-4e47-ba3d-d4afad63e1a1").update({
      "name": "Impact play",
      "created_at": "2019-09-22 10:13:48 UTC",
      "updated_at": "2019-09-22 10:13:48 UTC",
      "uuid": "001700b4-3c67-4e47-ba3d-d4afad63e1a1",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "01cda340-5823-4449-b08e-d2723fb5477b").update({
      "name": "Bookworm",
      "created_at": "2018-07-31 15:13:24 UTC",
      "updated_at": "2018-07-31 15:13:24 UTC",
      "uuid": "01cda340-5823-4449-b08e-d2723fb5477b",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "06358170-3ab0-43be-9d7a-c3ac70557bbc").update({
      "name": "Experimentalist",
      "created_at": "2019-09-22 09:59:04 UTC",
      "updated_at": "2019-09-22 09:59:04 UTC",
      "uuid": "06358170-3ab0-43be-9d7a-c3ac70557bbc",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "067ec2c7-5c23-40eb-96ad-f70f5b28f4f2").update({
      "name": "Puke Play",
      "created_at": "2019-11-26 10:53:19 UTC",
      "updated_at": "2019-11-26 10:53:19 UTC",
      "uuid": "067ec2c7-5c23-40eb-96ad-f70f5b28f4f2",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "06939034-412a-4fc5-aac7-1e1d442d2083").update({
      "name": "Vegan Furs",
      "created_at": "2019-06-06 17:51:50 UTC",
      "updated_at": "2019-06-06 17:52:16 UTC",
      "uuid": "06939034-412a-4fc5-aac7-1e1d442d2083",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "06bb7fc8-ce48-40c0-aa21-e36bac4e0e51").update({
      "name": "Fursuiter",
      "created_at": "2018-05-22 10:19:12 UTC",
      "updated_at": "2018-07-22 14:53:59 UTC",
      "uuid": "06bb7fc8-ce48-40c0-aa21-e36bac4e0e51",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "096cff44-a6f5-4b4f-a4b4-5a1c9d43931d").update({
      "name": "Sounding",
      "created_at": "2019-12-08 13:09:33 UTC",
      "updated_at": "2019-12-08 13:09:33 UTC",
      "uuid": "096cff44-a6f5-4b4f-a4b4-5a1c9d43931d",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "0a154774-a74c-497c-9e83-e9c4019f4034").update({
      "name": "Otherkin",
      "created_at": "2020-01-05 18:28:27 UTC",
      "updated_at": "2020-01-05 18:28:27 UTC",
      "uuid": "0a154774-a74c-497c-9e83-e9c4019f4034",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "0ca2e0a9-43c3-49c9-8197-14890d110e43").update({
      "name": "Biker",
      "created_at": "2018-07-31 15:13:24 UTC",
      "updated_at": "2018-07-31 15:13:24 UTC",
      "uuid": "0ca2e0a9-43c3-49c9-8197-14890d110e43",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "0d227c16-af86-4706-93ef-242de8acccb1").update({
      "name": "Femdom",
      "created_at": "2018-07-31 15:15:09 UTC",
      "updated_at": "2018-07-31 15:15:09 UTC",
      "uuid": "0d227c16-af86-4706-93ef-242de8acccb1",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "0d51f73e-cf8e-42ec-b7eb-d7f62099e483").update({
      "name": "Macro/micro",
      "created_at": "2021-08-04 19:14:46 UTC",
      "updated_at": "2021-08-04 19:14:46 UTC",
      "uuid": "0d51f73e-cf8e-42ec-b7eb-d7f62099e483",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "0dc61656-6386-4e1c-9ab3-c60c6ac8a4d2").update({
      "name": "Brat",
      "created_at": "2018-07-31 15:15:09 UTC",
      "updated_at": "2018-07-31 15:15:09 UTC",
      "uuid": "0dc61656-6386-4e1c-9ab3-c60c6ac8a4d2",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "0f9642d8-1a68-47dc-afde-0cae8e13cb8b").update({
      "name": "Camping furs",
      "created_at": "2019-12-28 17:39:32 UTC",
      "updated_at": "2019-12-28 17:39:32 UTC",
      "uuid": "0f9642d8-1a68-47dc-afde-0cae8e13cb8b",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "0fce3f35-f618-4ec4-8349-1adfb6a2672a").update({
      "name": "SonicFurs",
      "created_at": "2019-09-04 17:58:28 UTC",
      "updated_at": "2019-09-04 17:58:28 UTC",
      "uuid": "0fce3f35-f618-4ec4-8349-1adfb6a2672a",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "1006f7a4-bdc7-40d4-9936-db69e7ab5ab0").update({
      "name": "Voyeurism",
      "created_at": "2018-05-20 18:18:27 UTC",
      "updated_at": "2018-07-22 14:54:00 UTC",
      "uuid": "1006f7a4-bdc7-40d4-9936-db69e7ab5ab0",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "148649c2-1170-4afe-9b1b-771f1940efaf").update({
      "name": "Pegging",
      "created_at": "2018-07-31 15:15:09 UTC",
      "updated_at": "2018-07-31 15:15:09 UTC",
      "uuid": "148649c2-1170-4afe-9b1b-771f1940efaf",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "156653e0-5df4-4c5b-a636-252ae3033c3c").update({
      "name": "Small dicks",
      "created_at": "2019-12-26 15:31:58 UTC",
      "updated_at": "2019-12-26 15:31:58 UTC",
      "uuid": "156653e0-5df4-4c5b-a636-252ae3033c3c",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "1574eb2f-eb97-4cd6-b311-99ddf37bff9e").update({
      "name": "New in the fandom",
      "created_at": "2019-12-08 13:25:02 UTC",
      "updated_at": "2019-12-08 13:25:02 UTC",
      "uuid": "1574eb2f-eb97-4cd6-b311-99ddf37bff9e",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "16a5a66d-8516-4b01-9372-aa9147cca94e").update({
      "name": "Bronies",
      "created_at": "2018-07-31 15:13:24 UTC",
      "updated_at": "2018-07-31 15:13:24 UTC",
      "uuid": "16a5a66d-8516-4b01-9372-aa9147cca94e",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "17198f22-e120-45ac-a56c-d487dea4f21e").update({
      "name": "Musk",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-07-22 14:54:01 UTC",
      "uuid": "17198f22-e120-45ac-a56c-d487dea4f21e",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "18c4e66d-d204-43e2-b23a-e7198afb99ee").update({
      "name": "Motor Furs",
      "created_at": "2018-07-31 15:13:24 UTC",
      "updated_at": "2018-07-31 15:13:24 UTC",
      "uuid": "18c4e66d-d204-43e2-b23a-e7198afb99ee",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "19bc3740-c7d8-4233-bcd3-32baef236b6e").update({
      "name": "Findom",
      "created_at": "2021-08-04 19:10:18 UTC",
      "updated_at": "2021-08-04 19:10:18 UTC",
      "uuid": "19bc3740-c7d8-4233-bcd3-32baef236b6e",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "1db6351f-c92a-42ce-afc5-c02f362cbcda").update({
      "name": "Sports furs",
      "created_at": "2019-08-18 18:33:13 UTC",
      "updated_at": "2019-08-18 18:33:13 UTC",
      "uuid": "1db6351f-c92a-42ce-afc5-c02f362cbcda",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "1e7a88c6-5cd8-45aa-a8f6-b962f11f8d03").update({
      "name": "Belly Furs",
      "created_at": "2019-11-04 12:01:03 UTC",
      "updated_at": "2019-11-04 12:01:03 UTC",
      "uuid": "1e7a88c6-5cd8-45aa-a8f6-b962f11f8d03",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "1faeb4a0-e81b-4c32-849e-2db1d0de46d2").update({
      "name": "Medical Furs",
      "created_at": "2019-04-16 08:22:03 UTC",
      "updated_at": "2019-04-16 08:22:03 UTC",
      "uuid": "1faeb4a0-e81b-4c32-849e-2db1d0de46d2",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "21574f37-1377-481f-9b30-472fb40331f6").update({
      "name": "Green furs ",
      "created_at": "2021-11-07 16:21:00 UTC",
      "updated_at": "2021-11-07 16:21:00 UTC",
      "uuid": "21574f37-1377-481f-9b30-472fb40331f6",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "21d66493-938f-4abf-b2db-278acf6733cc").update({
      "name": "Meme lovers",
      "created_at": "2019-09-30 08:59:17 UTC",
      "updated_at": "2019-09-30 08:59:17 UTC",
      "uuid": "21d66493-938f-4abf-b2db-278acf6733cc",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "2355a6cb-c899-4f7b-b9bb-fd2731e349ff").update({
      "name": "Astronomers",
      "created_at": "2021-05-20 17:50:49 UTC",
      "updated_at": "2021-05-20 17:51:10 UTC",
      "uuid": "2355a6cb-c899-4f7b-b9bb-fd2731e349ff",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "259e26ac-86f2-4ea4-9397-edc8734726c6").update({
      "name": "Railway Furs",
      "created_at": "2019-12-28 17:37:56 UTC",
      "updated_at": "2019-12-28 17:37:56 UTC",
      "uuid": "259e26ac-86f2-4ea4-9397-edc8734726c6",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "27db78aa-629a-4d4c-a22f-284873cb2cdf").update({
      "name": "Service top",
      "created_at": "2019-08-24 09:29:58 UTC",
      "updated_at": "2019-08-24 09:29:58 UTC",
      "uuid": "27db78aa-629a-4d4c-a22f-284873cb2cdf",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "283741eb-2b0e-4172-a11f-487c3310e187").update({
      "name": "Gamer",
      "created_at": "2018-06-22 14:04:30 UTC",
      "updated_at": "2018-07-26 22:51:19 UTC",
      "uuid": "283741eb-2b0e-4172-a11f-487c3310e187",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "2b146945-048f-42ab-9d6a-04aeec5bac80").update({
      "name": "Scat",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-07-22 14:54:03 UTC",
      "uuid": "2b146945-048f-42ab-9d6a-04aeec5bac80",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "31bbf8aa-1c7b-42cd-9937-4466649b223c").update({
      "name": "Disney furs",
      "created_at": "2019-12-26 15:32:22 UTC",
      "updated_at": "2019-12-26 15:32:22 UTC",
      "uuid": "31bbf8aa-1c7b-42cd-9937-4466649b223c",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "329bf53f-8dcb-4b50-b1ef-f41ca3a84193").update({
      "name": "Hypnosis",
      "created_at": "2018-07-31 15:15:09 UTC",
      "updated_at": "2018-07-31 15:15:09 UTC",
      "uuid": "329bf53f-8dcb-4b50-b1ef-f41ca3a84193",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "33d54e39-c358-45c0-b425-8ee7be5bb9ea").update({
      "name": "Rock Climbing",
      "created_at": "2020-01-02 08:05:47 UTC",
      "updated_at": "2020-01-02 08:05:47 UTC",
      "uuid": "33d54e39-c358-45c0-b425-8ee7be5bb9ea",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "340ca1e6-bec2-4081-b385-648728158b3b").update({
      "name": "Numismatics",
      "created_at": "2019-03-18 14:15:47 UTC",
      "updated_at": "2019-03-18 14:15:47 UTC",
      "uuid": "340ca1e6-bec2-4081-b385-648728158b3b",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "3484ec74-e6f2-414d-a09f-6f354963cdf4").update({
      "name": "Airsoft",
      "created_at": "2019-06-17 15:26:27 UTC",
      "updated_at": "2019-06-17 15:26:27 UTC",
      "uuid": "3484ec74-e6f2-414d-a09f-6f354963cdf4",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "36a58f9b-b6d8-40f0-b729-27623b9ef91b").update({
      "name": "Butch",
      "created_at": "2018-07-31 15:13:24 UTC",
      "updated_at": "2018-07-31 15:13:24 UTC",
      "uuid": "36a58f9b-b6d8-40f0-b729-27623b9ef91b",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "373f0033-bd16-44e6-b9fc-62bf5da4ad91").update({
      "name": "Digifurs",
      "created_at": "2019-12-08 13:07:49 UTC",
      "updated_at": "2019-12-08 13:07:49 UTC",
      "uuid": "373f0033-bd16-44e6-b9fc-62bf5da4ad91",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "37beeb39-39cd-4c27-a9fb-894148d1892d").update({
      "name": "University Furs",
      "created_at": "2019-12-26 10:16:59 UTC",
      "updated_at": "2019-12-26 10:16:59 UTC",
      "uuid": "37beeb39-39cd-4c27-a9fb-894148d1892d",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "3813b384-c4ee-44fa-aadf-d4206cbd5b8c").update({
      "name": "Group Stuff",
      "created_at": "2018-07-31 15:15:09 UTC",
      "updated_at": "2018-07-31 15:15:09 UTC",
      "uuid": "3813b384-c4ee-44fa-aadf-d4206cbd5b8c",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "3a29d909-977f-47d9-a29c-66612da5e6ab").update({
      "name": "Edufurs",
      "created_at": "2019-06-23 19:11:24 UTC",
      "updated_at": "2019-06-23 19:11:24 UTC",
      "uuid": "3a29d909-977f-47d9-a29c-66612da5e6ab",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "3c84b740-bb1e-4437-8f9c-4aaffb5b5203").update({
      "name": "IT Furs",
      "created_at": "2018-07-09 10:36:47 UTC",
      "updated_at": "2018-07-22 14:54:03 UTC",
      "uuid": "3c84b740-bb1e-4437-8f9c-4aaffb5b5203",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "3d79aaeb-a7c6-4e0d-9401-9766a39fd007").update({
      "name": "Hybrids",
      "created_at": "2019-12-05 09:54:00 UTC",
      "updated_at": "2019-12-05 09:54:00 UTC",
      "uuid": "3d79aaeb-a7c6-4e0d-9401-9766a39fd007",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "3d808fbc-feb1-4f1c-9c7f-fa6b6acb0061").update({
      "name": "Plush",
      "created_at": "2019-05-25 22:35:08 UTC",
      "updated_at": "2019-05-25 22:35:08 UTC",
      "uuid": "3d808fbc-feb1-4f1c-9c7f-fa6b6acb0061",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "3eede1c6-48ca-4a24-a0f9-c9591b261b42").update({
      "name": "Therian",
      "created_at": "2020-01-05 18:28:30 UTC",
      "updated_at": "2020-01-05 18:28:30 UTC",
      "uuid": "3eede1c6-48ca-4a24-a0f9-c9591b261b42",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "43805332-2ba8-4950-8eb9-1ff52b0072fd").update({
      "name": "Enema Play",
      "created_at": "2019-11-26 10:54:26 UTC",
      "updated_at": "2019-11-26 10:54:26 UTC",
      "uuid": "43805332-2ba8-4950-8eb9-1ff52b0072fd",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "4473d4e9-b85a-42c2-a552-45c842b8d641").update({
      "name": "Bottom",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-07-22 14:54:04 UTC",
      "uuid": "4473d4e9-b85a-42c2-a552-45c842b8d641",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "44dee49b-5b0d-4f4e-bca5-162248038c52").update({
      "name": "Top",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-07-22 14:54:05 UTC",
      "uuid": "44dee49b-5b0d-4f4e-bca5-162248038c52",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "45124c61-0804-4d1f-9473-9caa0309cbf5").update({
      "name": "Knife furs",
      "created_at": "2019-08-18 18:21:12 UTC",
      "updated_at": "2019-08-18 18:21:12 UTC",
      "uuid": "45124c61-0804-4d1f-9473-9caa0309cbf5",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "454d8e45-5efe-4bcb-ba06-5ef0f76d4614").update({
      "name": "Anime Furs ",
      "created_at": "2019-12-08 13:25:42 UTC",
      "updated_at": "2019-12-08 13:25:42 UTC",
      "uuid": "454d8e45-5efe-4bcb-ba06-5ef0f76d4614",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "47b37878-c65c-46cd-8e59-1fe6b85497f2").update({
      "name": "Bitchsuits",
      "created_at": "2019-10-14 17:21:05 UTC",
      "updated_at": "2019-10-14 17:21:15 UTC",
      "uuid": "47b37878-c65c-46cd-8e59-1fe6b85497f2",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "490a20d8-f2ef-4d4f-bfc3-3d1d3e44780a").update({
      "name": "Couch-Surfing Host",
      "created_at": "2018-07-03 10:12:27 UTC",
      "updated_at": "2018-07-22 14:54:05 UTC",
      "uuid": "490a20d8-f2ef-4d4f-bfc3-3d1d3e44780a",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "492ef2ee-b803-470b-9a94-e107f78b5841").update({
      "name": "Photographer",
      "created_at": "2018-07-09 10:34:58 UTC",
      "updated_at": "2018-07-22 14:54:05 UTC",
      "uuid": "492ef2ee-b803-470b-9a94-e107f78b5841",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "4c6c236f-7af8-4f05-a3d4-ff51eadc8081").update({
      "name": "Diabetic Furs",
      "created_at": "2019-11-07 14:07:48 UTC",
      "updated_at": "2019-11-07 14:07:48 UTC",
      "uuid": "4c6c236f-7af8-4f05-a3d4-ff51eadc8081",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "4dcb6c25-3a8b-47f6-b6b7-aa935fb76e04").update({
      "name": "Vanilla",
      "created_at": "2018-06-22 14:03:54 UTC",
      "updated_at": "2018-07-22 14:54:06 UTC",
      "uuid": "4dcb6c25-3a8b-47f6-b6b7-aa935fb76e04",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "4e8f6866-aa55-42a7-81a5-35a3061484fb").update({
      "name": "Skater furs",
      "created_at": "2021-08-04 19:20:33 UTC",
      "updated_at": "2021-08-04 19:20:40 UTC",
      "uuid": "4e8f6866-aa55-42a7-81a5-35a3061484fb",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "50703e20-bcf6-4bc0-965c-c9b162352384").update({
      "name": "BDSM",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-07-22 14:54:06 UTC",
      "uuid": "50703e20-bcf6-4bc0-965c-c9b162352384",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "545f92ca-aefd-4c0c-9b23-b4bfbf41ca35").update({
      "name": "Watersports",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-07-22 14:54:07 UTC",
      "uuid": "545f92ca-aefd-4c0c-9b23-b4bfbf41ca35",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "554e33a3-d330-400e-9c67-5dff2a2c2cbb").update({
      "name": "Power Bottom",
      "created_at": "2019-06-27 14:09:38 UTC",
      "updated_at": "2019-06-27 14:09:38 UTC",
      "uuid": "554e33a3-d330-400e-9c67-5dff2a2c2cbb",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "557e4c8f-af9d-46e8-a95f-a56441c6726d").update({
      "name": "Electro Stim",
      "created_at": "2019-11-22 17:52:11 UTC",
      "updated_at": "2019-11-22 17:52:11 UTC",
      "uuid": "557e4c8f-af9d-46e8-a95f-a56441c6726d",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "572b40b1-f515-4214-aa4d-b58da076cc8b").update({
      "name": "Vape furs",
      "created_at": "2019-08-18 18:45:14 UTC",
      "updated_at": "2019-08-18 18:45:14 UTC",
      "uuid": "572b40b1-f515-4214-aa4d-b58da076cc8b",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "57d2d78f-a250-4482-8c28-1cc1b048692b").update({
      "name": "Gassy Furs",
      "created_at": "2019-11-26 10:35:47 UTC",
      "updated_at": "2019-11-26 10:35:47 UTC",
      "uuid": "57d2d78f-a250-4482-8c28-1cc1b048692b",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "586858b0-a278-416f-8795-eab1e2707e78").update({
      "name": "PokeFurs",
      "created_at": "2019-04-15 06:19:49 UTC",
      "updated_at": "2019-04-15 06:19:49 UTC",
      "uuid": "586858b0-a278-416f-8795-eab1e2707e78",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "591fbf85-f003-4f93-936f-96632d4489cf").update({
      "name": "Lockpicking",
      "created_at": "2021-08-04 19:14:00 UTC",
      "updated_at": "2021-08-04 19:14:00 UTC",
      "uuid": "591fbf85-f003-4f93-936f-96632d4489cf",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "598828bd-993f-44bf-82e3-2b951c511601").update({
      "name": "Shibari",
      "created_at": "2018-07-31 15:15:09 UTC",
      "updated_at": "2018-07-31 15:15:09 UTC",
      "uuid": "598828bd-993f-44bf-82e3-2b951c511601",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "5c4ed838-52cc-4fa0-a4d7-afebe16e30e1").update({
      "name": "Bodybuilder",
      "created_at": "2020-01-02 08:05:35 UTC",
      "updated_at": "2020-01-02 08:05:35 UTC",
      "uuid": "5c4ed838-52cc-4fa0-a4d7-afebe16e30e1",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "5c582c2a-da54-446d-84c4-e28cc2297af4").update({
      "name": "Twink",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-07-22 14:54:07 UTC",
      "uuid": "5c582c2a-da54-446d-84c4-e28cc2297af4",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "5d78f20d-4065-480f-8a73-dbafb129dedd").update({
      "name": "Fencing Furs",
      "created_at": "2019-12-08 11:48:05 UTC",
      "updated_at": "2019-12-08 11:48:05 UTC",
      "uuid": "5d78f20d-4065-480f-8a73-dbafb129dedd",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "5e6a0ef3-ba25-40f9-a3c6-53d41a7d8393").update({
      "name": "Paintball",
      "created_at": "2019-06-17 15:52:08 UTC",
      "updated_at": "2019-06-17 15:52:08 UTC",
      "uuid": "5e6a0ef3-ba25-40f9-a3c6-53d41a7d8393",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "5ea0dc5b-b62b-49d3-a4c9-462e8692505b").update({
      "name": "Femboy",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-07-22 14:54:13 UTC",
      "uuid": "5ea0dc5b-b62b-49d3-a4c9-462e8692505b",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "5eaedaa2-304c-4211-909f-1f0cde373ee4").update({
      "name": "Chaser",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-07-22 14:54:13 UTC",
      "uuid": "5eaedaa2-304c-4211-909f-1f0cde373ee4",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "644c73f5-de4a-4463-a0f1-3d50c7816fdf").update({
      "name": "Pony Play",
      "created_at": "2018-07-31 15:15:09 UTC",
      "updated_at": "2018-07-31 15:15:09 UTC",
      "uuid": "644c73f5-de4a-4463-a0f1-3d50c7816fdf",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "6494ee63-1fc6-4c0b-9fee-1d255b950c1e").update({
      "name": "Popping Furs",
      "created_at": "2019-10-23 14:25:34 UTC",
      "updated_at": "2019-11-04 11:45:43 UTC",
      "uuid": "6494ee63-1fc6-4c0b-9fee-1d255b950c1e",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "653557d9-b87e-48f4-ad84-e19fe14216b5").update({
      "name": "Chemsex",
      "created_at": "2021-08-04 19:10:29 UTC",
      "updated_at": "2021-08-04 19:10:29 UTC",
      "uuid": "653557d9-b87e-48f4-ad84-e19fe14216b5",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "6573f72f-2296-47f3-828a-f96ec4987a51").update({
      "name": "Nudist/naturalist furs",
      "created_at": "2019-07-01 16:57:56 UTC",
      "updated_at": "2019-07-01 16:57:56 UTC",
      "uuid": "6573f72f-2296-47f3-828a-f96ec4987a51",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "65d4481f-d56f-4801-ae9d-f9d16382dcba").update({
      "name": "Sock lovers",
      "created_at": "2021-08-04 19:21:13 UTC",
      "updated_at": "2021-08-04 19:21:13 UTC",
      "uuid": "65d4481f-d56f-4801-ae9d-f9d16382dcba",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "66cdcccb-df07-4d31-a1b2-12923a504b59").update({
      "name": "Exhibitionist",
      "created_at": "2018-05-20 18:19:18 UTC",
      "updated_at": "2018-07-22 14:54:14 UTC",
      "uuid": "66cdcccb-df07-4d31-a1b2-12923a504b59",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "691c6c3d-70ac-4e22-a224-a75ee355c9fe").update({
      "name": "Intersex",
      "created_at": "2021-08-04 19:17:33 UTC",
      "updated_at": "2021-08-04 19:17:33 UTC",
      "uuid": "691c6c3d-70ac-4e22-a224-a75ee355c9fe",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "6b416b96-fae1-4ad7-bb37-4a3b40cbf232").update({
      "name": "Drool",
      "created_at": "2021-08-04 19:09:24 UTC",
      "updated_at": "2021-08-04 19:09:24 UTC",
      "uuid": "6b416b96-fae1-4ad7-bb37-4a3b40cbf232",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "6d9a9ce4-02ed-420c-9496-9e657b9f21cd").update({
      "name": "Puppy",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-07-22 14:54:14 UTC",
      "uuid": "6d9a9ce4-02ed-420c-9496-9e657b9f21cd",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "6ee78ae4-3a81-491c-8d4d-a19fc8eac98c").update({
      "name": "Vore",
      "created_at": "2018-07-31 15:15:09 UTC",
      "updated_at": "2018-07-31 15:15:09 UTC",
      "uuid": "6ee78ae4-3a81-491c-8d4d-a19fc8eac98c",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "6ef44b15-0ea4-4dbd-be18-53af3c2569c7").update({
      "name": "Musician",
      "created_at": "2018-07-02 08:57:13 UTC",
      "updated_at": "2018-07-22 14:54:14 UTC",
      "uuid": "6ef44b15-0ea4-4dbd-be18-53af3c2569c7",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "7120e895-797e-44c0-9726-6ec52735ab29").update({
      "name": "Chastity",
      "created_at": "2018-07-02 08:59:40 UTC",
      "updated_at": "2018-07-22 14:54:15 UTC",
      "uuid": "7120e895-797e-44c0-9726-6ec52735ab29",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "71b3135c-bc75-40a6-a0cd-01b9432a2e78").update({
      "name": "History Furs",
      "created_at": "2019-11-07 15:14:07 UTC",
      "updated_at": "2019-11-16 09:44:06 UTC",
      "uuid": "71b3135c-bc75-40a6-a0cd-01b9432a2e78",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "74226a88-cb88-49ee-a7dd-165665028681").update({
      "name": "Feedee Furs",
      "created_at": "2019-06-17 15:17:46 UTC",
      "updated_at": "2019-06-17 15:17:46 UTC",
      "uuid": "74226a88-cb88-49ee-a7dd-165665028681",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "75599051-784d-43fc-af6b-0a05890bc2f3").update({
      "name": "Chubby",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-07-22 14:54:15 UTC",
      "uuid": "75599051-784d-43fc-af6b-0a05890bc2f3",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "790f81f2-3a03-4de4-b3c5-59408bf3d813").update({
      "name": "Big dicks",
      "created_at": "2019-12-28 17:38:05 UTC",
      "updated_at": "2019-12-28 17:38:05 UTC",
      "uuid": "790f81f2-3a03-4de4-b3c5-59408bf3d813",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "794e21d9-c7ee-47fb-b354-f999a6dc880e").update({
      "name": "Introvert",
      "created_at": "2019-12-29 12:51:58 UTC",
      "updated_at": "2019-12-29 12:51:58 UTC",
      "uuid": "794e21d9-c7ee-47fb-b354-f999a6dc880e",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "7a0bde55-079a-4f81-8eb4-932fbd2bab4a").update({
      "name": "I love sex",
      "created_at": "2019-06-23 14:29:11 UTC",
      "updated_at": "2019-06-23 14:29:11 UTC",
      "uuid": "7a0bde55-079a-4f81-8eb4-932fbd2bab4a",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "7ba05750-5355-4856-94fe-ff6f079db7c7").update({
      "name": "VR furs",
      "created_at": "2021-08-04 19:15:58 UTC",
      "updated_at": "2021-08-04 19:15:58 UTC",
      "uuid": "7ba05750-5355-4856-94fe-ff6f079db7c7",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "7c79c1a8-8ad3-44d4-8410-156a19862f98").update({
      "name": "Law Enforcement Furs",
      "created_at": "2019-09-22 13:14:50 UTC",
      "updated_at": "2019-09-22 13:15:55 UTC",
      "uuid": "7c79c1a8-8ad3-44d4-8410-156a19862f98",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "7d265a51-3a14-452a-9aaf-98669c4fcee8").update({
      "name": "Geocaching Furs",
      "created_at": "2019-12-26 15:22:56 UTC",
      "updated_at": "2019-12-26 15:22:56 UTC",
      "uuid": "7d265a51-3a14-452a-9aaf-98669c4fcee8",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "810e1887-94d4-445b-8832-9a87ef5499b8").update({
      "name": "Kitty play",
      "created_at": "2019-08-18 18:37:20 UTC",
      "updated_at": "2019-08-18 18:37:20 UTC",
      "uuid": "810e1887-94d4-445b-8832-9a87ef5499b8",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "8199096f-d5ea-45c6-b1cd-8f5d0066c633").update({
      "name": "Boardgames",
      "created_at": "2020-01-06 12:16:22 UTC",
      "updated_at": "2020-01-06 12:16:22 UTC",
      "uuid": "8199096f-d5ea-45c6-b1cd-8f5d0066c633",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "838bc226-88e2-466e-8f50-f51f2f9d49e6").update({
      "name": "Breathplay",
      "created_at": "2018-07-02 08:58:45 UTC",
      "updated_at": "2018-07-22 14:54:16 UTC",
      "uuid": "838bc226-88e2-466e-8f50-f51f2f9d49e6",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "85234bbd-fedf-4603-8987-9872ed007f81").update({
      "name": "Thalassophiles",
      "created_at": "2019-10-28 10:04:18 UTC",
      "updated_at": "2019-10-28 10:04:18 UTC",
      "uuid": "85234bbd-fedf-4603-8987-9872ed007f81",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "858356b5-bcfa-405a-807f-64d75a4a3f19").update({
      "name": "Size Difference",
      "created_at": "2018-07-31 15:15:09 UTC",
      "updated_at": "2018-07-31 15:15:09 UTC",
      "uuid": "858356b5-bcfa-405a-807f-64d75a4a3f19",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "8874789d-254e-4c61-b21d-8ff7da5ca6ae").update({
      "name": "Docking",
      "created_at": "2020-01-05 14:09:19 UTC",
      "updated_at": "2020-01-05 14:09:19 UTC",
      "uuid": "8874789d-254e-4c61-b21d-8ff7da5ca6ae",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "8ea4ee3d-28f0-4536-8c77-beaa1137ba0b").update({
      "name": "WAM",
      "created_at": "2019-12-08 13:15:14 UTC",
      "updated_at": "2019-12-08 13:15:14 UTC",
      "uuid": "8ea4ee3d-28f0-4536-8c77-beaa1137ba0b",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "8ef527c2-a7fd-46db-8248-c1b7311282da").update({
      "name": "Spiritual furs",
      "created_at": "2019-07-03 07:33:57 UTC",
      "updated_at": "2019-07-03 07:33:57 UTC",
      "uuid": "8ef527c2-a7fd-46db-8248-c1b7311282da",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "901e83d5-6e78-474b-b521-634c1e79eb77").update({
      "name": "Archery",
      "created_at": "2019-12-28 17:39:24 UTC",
      "updated_at": "2019-12-28 17:39:24 UTC",
      "uuid": "901e83d5-6e78-474b-b521-634c1e79eb77",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "9288140b-fafa-4eb7-acd4-37e3a326a4b9").update({
      "name": "Firefighter furs",
      "created_at": "2019-09-25 12:27:25 UTC",
      "updated_at": "2019-09-25 12:27:25 UTC",
      "uuid": "9288140b-fafa-4eb7-acd4-37e3a326a4b9",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "981b8e53-7640-40f8-aef7-5966d6352f47").update({
      "name": "Military Furs",
      "created_at": "2019-05-24 22:06:46 UTC",
      "updated_at": "2019-05-24 22:06:46 UTC",
      "uuid": "981b8e53-7640-40f8-aef7-5966d6352f47",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "984522b9-5559-4552-92fe-a6a878bb0246").update({
      "name": "Silent moaners",
      "created_at": "2019-12-24 11:08:35 UTC",
      "updated_at": "2019-12-24 11:08:35 UTC",
      "uuid": "984522b9-5559-4552-92fe-a6a878bb0246",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "9868a2b6-e5b0-4563-afd8-a75a4272d48c").update({
      "name": "Dancer Furs",
      "created_at": "2019-10-07 16:47:43 UTC",
      "updated_at": "2019-10-08 15:18:29 UTC",
      "uuid": "9868a2b6-e5b0-4563-afd8-a75a4272d48c",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "9b194814-4e7d-4ab9-b8b5-178355f0f176").update({
      "name": "Rubber",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-07-22 14:54:17 UTC",
      "uuid": "9b194814-4e7d-4ab9-b8b5-178355f0f176",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "9b43f620-7954-4f9f-8158-9d58754f1029").update({
      "name": "Smoking furs",
      "created_at": "2019-03-05 20:21:50 UTC",
      "updated_at": "2019-03-05 20:21:50 UTC",
      "uuid": "9b43f620-7954-4f9f-8158-9d58754f1029",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "9d70f464-7175-4e15-9a5f-5fedcb72887f").update({
      "name": "Dom",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-07-22 14:54:17 UTC",
      "uuid": "9d70f464-7175-4e15-9a5f-5fedcb72887f",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "9dac4dc2-28f4-44f3-817a-89ec975a4e31").update({
      "name": "Bull",
      "created_at": "2019-10-23 17:03:06 UTC",
      "updated_at": "2019-10-23 17:16:45 UTC",
      "uuid": "9dac4dc2-28f4-44f3-817a-89ec975a4e31",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "9e61b73d-211c-43a7-b8f9-2f7623efcdc7").update({
      "name": "Cooking furs",
      "created_at": "2019-07-18 10:41:02 UTC",
      "updated_at": "2019-07-18 10:41:02 UTC",
      "uuid": "9e61b73d-211c-43a7-b8f9-2f7623efcdc7",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "9ed5fe5d-3663-4199-8450-dfa688acd464").update({
      "name": "Firearms Furs",
      "created_at": "2019-05-25 21:14:56 UTC",
      "updated_at": "2019-05-25 21:14:56 UTC",
      "uuid": "9ed5fe5d-3663-4199-8450-dfa688acd464",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "a030f61d-102a-41a1-91ed-50c9ce005f6c").update({
      "name": "Edging",
      "created_at": "2019-11-26 10:27:44 UTC",
      "updated_at": "2019-11-26 10:27:44 UTC",
      "uuid": "a030f61d-102a-41a1-91ed-50c9ce005f6c",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "a0fde6bb-05b1-4655-b4ff-15e6e4237837").update({
      "name": "Hyper",
      "created_at": "2019-12-28 17:38:55 UTC",
      "updated_at": "2019-12-28 17:38:55 UTC",
      "uuid": "a0fde6bb-05b1-4655-b4ff-15e6e4237837",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "a20521ca-0917-461c-869e-a85eb3d87798").update({
      "name": "Sub",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-07-22 14:54:17 UTC",
      "uuid": "a20521ca-0917-461c-869e-a85eb3d87798",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "a22c655f-cba1-4474-a8a1-0f8fc9676f9e").update({
      "name": "Arcade Furs",
      "created_at": "2019-12-28 17:39:54 UTC",
      "updated_at": "2019-12-28 17:39:54 UTC",
      "uuid": "a22c655f-cba1-4474-a8a1-0f8fc9676f9e",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "a36d3a15-1a46-4bb7-a04c-4758393daee5").update({
      "name": "Mummification",
      "created_at": "2019-10-14 17:20:30 UTC",
      "updated_at": "2019-10-14 17:20:30 UTC",
      "uuid": "a36d3a15-1a46-4bb7-a04c-4758393daee5",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "a5262699-29d2-4418-8a9c-8beb1b342bf5").update({
      "name": "Face Sitting",
      "created_at": "2019-12-26 15:55:26 UTC",
      "updated_at": "2019-12-26 15:56:10 UTC",
      "uuid": "a5262699-29d2-4418-8a9c-8beb1b342bf5",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "a70e6fc5-a6f7-4fc6-a0ac-6120b6bf5c98").update({
      "name": "Hockey",
      "created_at": "2019-12-28 08:26:27 UTC",
      "updated_at": "2019-12-28 08:26:27 UTC",
      "uuid": "a70e6fc5-a6f7-4fc6-a0ac-6120b6bf5c98",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "a93240bc-3f57-423c-b83e-6cdb7aeeb734").update({
      "name": "Paranormal Furs",
      "created_at": "2019-12-08 13:24:07 UTC",
      "updated_at": "2019-12-08 13:24:07 UTC",
      "uuid": "a93240bc-3f57-423c-b83e-6cdb7aeeb734",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "abb3b3fa-6a91-4e1d-9e8b-acd293dab927").update({
      "name": "Stoner Furs",
      "created_at": "2019-11-07 15:12:22 UTC",
      "updated_at": "2019-11-11 17:10:22 UTC",
      "uuid": "abb3b3fa-6a91-4e1d-9e8b-acd293dab927",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "ac9fe914-ce33-410d-a05e-a223910f67b9").update({
      "name": "Science Furs",
      "created_at": "2018-07-31 15:13:24 UTC",
      "updated_at": "2018-07-31 15:13:24 UTC",
      "uuid": "ac9fe914-ce33-410d-a05e-a223910f67b9",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "b1cf17e5-0f0f-4660-934c-ade724a6c27a").update({
      "name": "ABDL",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-07-22 14:54:18 UTC",
      "uuid": "b1cf17e5-0f0f-4660-934c-ade724a6c27a",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "b1ee24ad-3c8c-4a74-bae3-57ef9813e7d6").update({
      "name": "Switch",
      "created_at": "2018-07-02 08:36:48 UTC",
      "updated_at": "2018-07-22 14:54:18 UTC",
      "uuid": "b1ee24ad-3c8c-4a74-bae3-57ef9813e7d6",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "b31670fd-74ba-4c2f-a539-74331d3d49e3").update({
      "name": "Swinging",
      "created_at": "2018-07-31 15:15:09 UTC",
      "updated_at": "2018-07-31 15:15:09 UTC",
      "uuid": "b31670fd-74ba-4c2f-a539-74331d3d49e3",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "b387b29e-4567-4220-b39d-a4ed31da06f1").update({
      "name": "Urban Explorers",
      "created_at": "2019-12-08 13:24:38 UTC",
      "updated_at": "2019-12-26 15:57:17 UTC",
      "uuid": "b387b29e-4567-4220-b39d-a4ed31da06f1",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "b47b3b2a-6896-4a68-854c-6ba23448fff7").update({
      "name": "Monogamous",
      "created_at": "2021-08-04 19:12:47 UTC",
      "updated_at": "2021-08-04 19:12:47 UTC",
      "uuid": "b47b3b2a-6896-4a68-854c-6ba23448fff7",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "b5ccb28b-42bb-4a8c-925f-1ed2f9cd5a13").update({
      "name": "Writer",
      "created_at": "2018-07-09 10:31:32 UTC",
      "updated_at": "2018-07-22 14:54:19 UTC",
      "uuid": "b5ccb28b-42bb-4a8c-925f-1ed2f9cd5a13",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "b629482a-92dd-4e52-9cec-7f87d78eae01").update({
      "name": "Murrsuiter",
      "created_at": "2018-05-22 09:39:20 UTC",
      "updated_at": "2018-07-22 14:54:19 UTC",
      "uuid": "b629482a-92dd-4e52-9cec-7f87d78eae01",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "bbb2beb5-af30-4ae4-ac9b-3af844bc46ef").update({
      "name": "Hip-Hop Furs",
      "created_at": "2019-11-22 17:35:20 UTC",
      "updated_at": "2019-11-22 17:35:55 UTC",
      "uuid": "bbb2beb5-af30-4ae4-ac9b-3af844bc46ef",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "bd59fe20-d344-498a-9868-3b40735a12f4").update({
      "name": "Trans",
      "created_at": "2018-05-20 20:45:04 UTC",
      "updated_at": "2018-07-22 14:54:19 UTC",
      "uuid": "bd59fe20-d344-498a-9868-3b40735a12f4",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "be4a0981-21f3-4609-8bf3-455fa283a4e6").update({
      "name": "Polyamorous",
      "created_at": "2021-08-04 19:16:43 UTC",
      "updated_at": "2021-08-04 19:16:43 UTC",
      "uuid": "be4a0981-21f3-4609-8bf3-455fa283a4e6",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "bfd06d59-69e2-4111-a398-a61c4d9a389a").update({
      "name": "Cuckolding",
      "created_at": "2019-10-23 17:01:55 UTC",
      "updated_at": "2019-10-23 17:17:08 UTC",
      "uuid": "bfd06d59-69e2-4111-a398-a61c4d9a389a",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "c195ec8b-7896-429e-9e63-90665b8d67a2").update({
      "name": "Vegetarian Furs",
      "created_at": "2019-12-28 17:38:15 UTC",
      "updated_at": "2019-12-28 17:38:15 UTC",
      "uuid": "c195ec8b-7896-429e-9e63-90665b8d67a2",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "c3fe43cb-0b64-4b12-9342-940fcd8afe1b").update({
      "name": "PregFurs",
      "created_at": "2019-10-07 16:44:02 UTC",
      "updated_at": "2019-10-07 16:44:02 UTC",
      "uuid": "c3fe43cb-0b64-4b12-9342-940fcd8afe1b",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "c8295993-1f87-4e7e-b001-8f137e76678e").update({
      "name": "Bear",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-07-22 14:54:22 UTC",
      "uuid": "c8295993-1f87-4e7e-b001-8f137e76678e",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "c9793f44-55e4-43fd-981e-7ab152c28d6f").update({
      "name": "Leather",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-07-22 14:54:22 UTC",
      "uuid": "c9793f44-55e4-43fd-981e-7ab152c28d6f",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "ca5d728c-8f80-4cee-b8d8-34e7eadc14dc").update({
      "name": "Feet lovers",
      "created_at": "2019-09-12 18:41:40 UTC",
      "updated_at": "2019-09-12 18:41:40 UTC",
      "uuid": "ca5d728c-8f80-4cee-b8d8-34e7eadc14dc",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "cacbfa4e-b1ab-440f-aec2-7d6506cf2a24").update({
      "name": "Transformation",
      "created_at": "2019-05-06 14:00:35 UTC",
      "updated_at": "2019-05-06 14:00:35 UTC",
      "uuid": "cacbfa4e-b1ab-440f-aec2-7d6506cf2a24",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "cd0c0161-e5b9-4168-b6fc-e3fcc53234db").update({
      "name": "Extrovert",
      "created_at": "2019-12-29 12:52:02 UTC",
      "updated_at": "2019-12-29 12:52:02 UTC",
      "uuid": "cd0c0161-e5b9-4168-b6fc-e3fcc53234db",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "d11eafb3-876f-4113-8cdb-7d314ce1369b").update({
      "name": "Artist",
      "created_at": "2018-07-02 08:53:38 UTC",
      "updated_at": "2018-07-22 14:54:23 UTC",
      "uuid": "d11eafb3-876f-4113-8cdb-7d314ce1369b",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "d1eb35ab-6a52-4251-8c43-049ab6fc92d5").update({
      "name": "Nude sharing",
      "created_at": "2021-03-18 18:53:40 UTC",
      "updated_at": "2021-03-18 18:53:40 UTC",
      "uuid": "d1eb35ab-6a52-4251-8c43-049ab6fc92d5",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "d26e63ba-f4d2-4927-b03a-37aa3f2a6130").update({
      "name": "Grey Muzzle",
      "created_at": "2018-06-22 14:03:32 UTC",
      "updated_at": "2018-07-22 14:54:23 UTC",
      "uuid": "d26e63ba-f4d2-4927-b03a-37aa3f2a6130",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "d49a2181-12fb-4407-848d-373ec2829dab").update({
      "name": "Femme",
      "created_at": "2018-07-31 15:13:24 UTC",
      "updated_at": "2018-07-31 15:13:24 UTC",
      "uuid": "d49a2181-12fb-4407-848d-373ec2829dab",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "d5810370-6153-4ef1-b58b-aa2232fc59ed").update({
      "name": "Fluffy Furs",
      "created_at": "2018-07-31 15:13:24 UTC",
      "updated_at": "2018-07-31 15:13:24 UTC",
      "uuid": "d5810370-6153-4ef1-b58b-aa2232fc59ed",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "d724c70d-c527-46de-8d8b-42c8148af4cb").update({
      "name": "Paws",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-07-22 14:54:24 UTC",
      "uuid": "d724c70d-c527-46de-8d8b-42c8148af4cb",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "dae7ac50-9944-45b4-bc97-6e66d8b0a876").update({
      "name": "Mechanic and construction",
      "created_at": "2019-03-05 20:22:59 UTC",
      "updated_at": "2019-03-05 20:22:59 UTC",
      "uuid": "dae7ac50-9944-45b4-bc97-6e66d8b0a876",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "dcc3ca5e-ad05-404f-ad59-63951b602b90").update({
      "name": "Travel Furs",
      "created_at": "2019-12-05 09:54:23 UTC",
      "updated_at": "2019-12-05 09:54:23 UTC",
      "uuid": "dcc3ca5e-ad05-404f-ad59-63951b602b90",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "dd5e351b-f7e3-41f9-b128-abe633b2aac1").update({
      "name": "Amateur radio Furs",
      "created_at": "2019-11-04 10:50:09 UTC",
      "updated_at": "2019-11-04 10:50:09 UTC",
      "uuid": "dd5e351b-f7e3-41f9-b128-abe633b2aac1",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "ddb0f9e6-a247-4b65-81c4-72fa5fed7d91").update({
      "name": "Inflatables",
      "created_at": "2018-07-09 10:34:14 UTC",
      "updated_at": "2018-07-22 14:54:24 UTC",
      "uuid": "ddb0f9e6-a247-4b65-81c4-72fa5fed7d91",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "df5189c8-ca2f-4214-97ae-e7a05923e81f").update({
      "name": "Fursuit Makers",
      "created_at": "2019-12-05 09:42:38 UTC",
      "updated_at": "2019-12-05 09:42:38 UTC",
      "uuid": "df5189c8-ca2f-4214-97ae-e7a05923e81f",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "df5ffcac-3648-4c64-aa8d-f6ac23418c3f").update({
      "name": "Looking for rent/room mate",
      "created_at": "2019-06-09 06:30:41 UTC",
      "updated_at": "2019-06-09 06:30:41 UTC",
      "uuid": "df5ffcac-3648-4c64-aa8d-f6ac23418c3f",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "e00714dc-16af-4a7f-9ce8-2063c5e67606").update({
      "name": "Gym Furs",
      "created_at": "2018-07-31 15:13:24 UTC",
      "updated_at": "2018-07-31 15:13:24 UTC",
      "uuid": "e00714dc-16af-4a7f-9ce8-2063c5e67606",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "e085000b-7808-4d90-8f03-62dd3c82966a").update({
      "name": "Tickling",
      "created_at": "2019-05-14 20:38:13 UTC",
      "updated_at": "2019-05-14 20:38:13 UTC",
      "uuid": "e085000b-7808-4d90-8f03-62dd3c82966a",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "e45224f2-5e08-4d9b-ad01-d3df788799dd").update({
      "name": "Rimming",
      "created_at": "2018-07-31 15:15:09 UTC",
      "updated_at": "2018-07-31 15:15:09 UTC",
      "uuid": "e45224f2-5e08-4d9b-ad01-d3df788799dd",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "e4bd16f3-2716-4a87-946d-7876c6936319").update({
      "name": "Body Modification",
      "created_at": "2019-10-07 19:50:00 UTC",
      "updated_at": "2019-10-07 19:50:00 UTC",
      "uuid": "e4bd16f3-2716-4a87-946d-7876c6936319",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "e6aa25d3-66ac-4904-9a83-ff18e4b8d069").update({
      "name": "Lasertag",
      "created_at": "2019-10-28 10:02:24 UTC",
      "updated_at": "2019-10-28 10:02:24 UTC",
      "uuid": "e6aa25d3-66ac-4904-9a83-ff18e4b8d069",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "e6d22928-32db-4283-8bad-508d562b9c36").update({
      "name": "Foreskin",
      "created_at": "2019-12-08 13:32:13 UTC",
      "updated_at": "2019-12-08 13:32:13 UTC",
      "uuid": "e6d22928-32db-4283-8bad-508d562b9c36",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "ea73f81d-a80c-4feb-8780-2e4d69b79c79").update({
      "name": "Role Player",
      "created_at": "2018-07-31 15:13:24 UTC",
      "updated_at": "2018-07-31 15:13:24 UTC",
      "uuid": "ea73f81d-a80c-4feb-8780-2e4d69b79c79",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "ea99245c-740a-4d32-8596-aa542781a9d4").update({
      "name": "Otter",
      "created_at": "2019-12-28 17:38:23 UTC",
      "updated_at": "2019-12-28 17:38:23 UTC",
      "uuid": "ea99245c-740a-4d32-8596-aa542781a9d4",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "ec1aff6f-d13a-4548-9b47-9f03c8e2f0be").update({
      "name": "Law Furs",
      "created_at": "2019-12-05 09:54:45 UTC",
      "updated_at": "2019-12-05 09:54:45 UTC",
      "uuid": "ec1aff6f-d13a-4548-9b47-9f03c8e2f0be",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "ec74bd2a-04de-456b-9c4e-0a7a88311b00").update({
      "name": "Taurs",
      "created_at": "2019-12-26 15:22:25 UTC",
      "updated_at": "2019-12-26 15:22:25 UTC",
      "uuid": "ec74bd2a-04de-456b-9c4e-0a7a88311b00",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "ee9c5d40-c83d-4137-9252-750c12dc72fa").update({
      "name": "Animation Furs",
      "created_at": "2019-09-22 13:11:29 UTC",
      "updated_at": "2019-09-22 13:11:29 UTC",
      "uuid": "ee9c5d40-c83d-4137-9252-750c12dc72fa",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "f2064e08-96ee-4d48-a622-6ab214a4bcb3").update({
      "name": "Fisting",
      "created_at": "2018-07-31 15:15:09 UTC",
      "updated_at": "2018-07-31 15:15:09 UTC",
      "uuid": "f2064e08-96ee-4d48-a622-6ab214a4bcb3",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "fbf2f4fa-c0b0-4acd-9357-666546b445e0").update({
      "name": "Aviation Furs",
      "created_at": "2019-12-08 12:01:17 UTC",
      "updated_at": "2019-12-08 12:01:17 UTC",
      "uuid": "fbf2f4fa-c0b0-4acd-9357-666546b445e0",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "fd440541-4edb-4667-8c03-cabf0a10d0b9").update({
      "name": "Feeder Furs",
      "created_at": "2019-06-17 15:17:19 UTC",
      "updated_at": "2019-06-17 15:17:24 UTC",
      "uuid": "fd440541-4edb-4667-8c03-cabf0a10d0b9",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    Group.find_or_create_by(uuid: "fe574127-b500-4408-ae9b-aca97c513d1d").update({
      "name": "Fashion furs",
      "created_at": "2021-08-04 19:15:37 UTC",
      "updated_at": "2021-08-04 19:15:37 UTC",
      "uuid": "fe574127-b500-4408-ae9b-aca97c513d1d",
      "group_category_id": "f5d78fb9-d803-4866-a9e0-afc6da08ffaa"
    })
    Group.find_or_create_by(uuid: "ff466c03-1b6c-46ed-afe2-096b5f3f8eaf").update({
      "name": "CBT",
      "created_at": "2018-07-31 15:15:09 UTC",
      "updated_at": "2018-07-31 15:15:09 UTC",
      "uuid": "ff466c03-1b6c-46ed-afe2-096b5f3f8eaf",
      "group_category_id": "72aed10d-5c37-4117-8b35-8a82d6bec068"
    })
    MatchKind.find_or_create_by(uuid: "af9bd6c8-134e-40cd-9d66-f38f7097f4e8").update({
      "name": "fuck",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-18 14:52:22 UTC",
      "label": "Hook Up",
      "uuid": "af9bd6c8-134e-40cd-9d66-f38f7097f4e8",
      "order": 3
    })
    MatchKind.find_or_create_by(uuid: "bd3a08d4-7018-407f-b8ec-0edb6bae159e").update({
      "name": "snug",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-20 17:17:45 UTC",
      "label": "Snug",
      "uuid": "bd3a08d4-7018-407f-b8ec-0edb6bae159e",
      "order": 2
    })
    MatchKind.find_or_create_by(uuid: "ca502da0-9bf6-4c73-8f7b-b64c41a62e4a").update({
      "name": "hang",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-18 14:52:42 UTC",
      "label": "Hang Out",
      "uuid": "ca502da0-9bf6-4c73-8f7b-b64c41a62e4a",
      "order": 1
    })
    MatchKind.find_or_create_by(uuid: "fc38c9ac-5693-4f1b-8e36-47f41a1ce7c2").update({
      "name": "chat",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-18 14:52:53 UTC",
      "label": "Chat",
      "uuid": "fc38c9ac-5693-4f1b-8e36-47f41a1ce7c2",
      "order": 0
    })
    ProfileFieldGroup.find_or_create_by(uuid: "26b8cddc-1431-4de4-8212-15f8cee7268f").update({
      "label": "Yiff",
      "created_at": "2020-11-17 16:21:22 UTC",
      "updated_at": "2020-11-21 22:18:16 UTC",
      "uuid": "26b8cddc-1431-4de4-8212-15f8cee7268f",
      "order": 4
    })
    ProfileFieldGroup.find_or_create_by(uuid: "33d413b2-1df6-4852-8dce-2d7f10d7e1d0").update({
      "label": "Messaging",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2021-07-25 16:23:34 UTC",
      "uuid": "33d413b2-1df6-4852-8dce-2d7f10d7e1d0",
      "order": 1
    })
    ProfileFieldGroup.find_or_create_by(uuid: "481d9228-c5a4-460b-93a4-5442b505a749").update({
      "label": "Gaming",
      "created_at": "2020-11-17 16:26:50 UTC",
      "updated_at": "2020-11-17 16:32:44 UTC",
      "uuid": "481d9228-c5a4-460b-93a4-5442b505a749",
      "order": 5
    })
    ProfileFieldGroup.find_or_create_by(uuid: "8dbdf963-a5d8-45e0-a595-0965d3ecb540").update({
      "label": "Social",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2020-11-17 16:27:47 UTC",
      "uuid": "8dbdf963-a5d8-45e0-a595-0965d3ecb540",
      "order": 3
    })
    ProfileFieldGroup.find_or_create_by(uuid: "8e55e087-8472-489f-bdd6-8a947573adbb").update({
      "label": "Other",
      "created_at": "2018-06-18 08:03:48 UTC",
      "updated_at": "2020-11-21 22:17:15 UTC",
      "uuid": "8e55e087-8472-489f-bdd6-8a947573adbb",
      "order": 6
    })
    ProfileFieldGroup.find_or_create_by(uuid: "9123ae15-dc21-42c9-8fcd-cd8a1473d514").update({
      "label": "Art",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2020-11-21 22:15:08 UTC",
      "uuid": "9123ae15-dc21-42c9-8fcd-cd8a1473d514",
      "order": 2
    })
    ProfileField.find_or_create_by(uuid: "0630c611-43f5-4b8e-8120-875e833302c1").update({
      "profile_field_group_id": "33d413b2-1df6-4852-8dce-2d7f10d7e1d0",
      "name": "discord",
      "label": "Discord",
      "created_at": "2018-08-09 19:13:52 UTC",
      "updated_at": "2021-07-25 16:23:34 UTC",
      "uuid": "0630c611-43f5-4b8e-8120-875e833302c1",
      "pattern": "",
      "regexp": "",
      "validation": "",
      "deep_link_pattern": "",
      "app_store_id": "",
      "play_store_id": "",
      "description": "Still better than Slack!",
      "restricted": true
    })
    ProfileField.find_or_create_by(uuid: "0bf8ae08-e90e-426c-9471-e6420a71aaf3").update({
      "profile_field_group_id": "9123ae15-dc21-42c9-8fcd-cd8a1473d514",
      "name": "weasyl",
      "label": "Weasyl",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2020-11-21 22:15:08 UTC",
      "uuid": "0bf8ae08-e90e-426c-9471-e6420a71aaf3",
      "pattern": "https://weasyl.com/~username",
      "regexp": "weasyl\\.com\\/\\~([\\w|\\-|\\_|\\&]*)",
      "validation": "^[a-z0-9A-Z_\\.-]+$",
      "deep_link_pattern": "",
      "app_store_id": "",
      "play_store_id": "",
      "description": "I like it, but I'm still not sure how to pronounce it.",
      "restricted": false
    })
    ProfileField.find_or_create_by(uuid: "1c9f3de9-3d21-4688-bfd6-60bc48ae895c").update({
      "profile_field_group_id": "481d9228-c5a4-460b-93a4-5442b505a749",
      "name": "twitch",
      "label": "Twitch",
      "created_at": "2020-11-17 16:32:12 UTC",
      "updated_at": "2020-11-17 16:32:44 UTC",
      "uuid": "1c9f3de9-3d21-4688-bfd6-60bc48ae895c",
      "pattern": "https://twitch.tv/username",
      "regexp": "twitch\\.tv\\/([\\w|\\-|\\_|\\&]*)",
      "validation": "^[a-z0-9A-Z_\\.-]+$",
      "deep_link_pattern": "",
      "app_store_id": "",
      "play_store_id": "",
      "description": "",
      "restricted": false
    })
    ProfileField.find_or_create_by(uuid: "42799fcf-7cba-4d02-b63d-abec0f9ed134").update({
      "profile_field_group_id": "26b8cddc-1431-4de4-8212-15f8cee7268f",
      "name": "murrtube",
      "label": "Murrtube",
      "created_at": "2020-11-17 16:24:17 UTC",
      "updated_at": "2020-11-17 16:24:17 UTC",
      "uuid": "42799fcf-7cba-4d02-b63d-abec0f9ed134",
      "pattern": "https://murrtube.net/username",
      "regexp": "murrtube\\.net\\/([\\w|\\-|\\_|\\&]*)",
      "validation": "^[a-z0-9A-Z_\\.-]+$",
      "deep_link_pattern": "",
      "app_store_id": "",
      "play_store_id": "",
      "description": "",
      "restricted": false
    })
    ProfileField.find_or_create_by(uuid: "477067af-9c3e-4e65-8dd0-070cadc5f415").update({
      "profile_field_group_id": "8dbdf963-a5d8-45e0-a595-0965d3ecb540",
      "name": "instagram",
      "label": "Instagram",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2020-11-17 15:19:10 UTC",
      "uuid": "477067af-9c3e-4e65-8dd0-070cadc5f415",
      "pattern": "https://instagram.com/username",
      "regexp": "instagram\\.com\\/([\\w|\\-|\\_|\\&]*)",
      "validation": "^[a-z0-9A-Z_\\.-]+$",
      "deep_link_pattern": "",
      "app_store_id": "",
      "play_store_id": "",
      "description": "",
      "restricted": false
    })
    ProfileField.find_or_create_by(uuid: "56a39e65-df40-4a58-8fdb-1a117fb6cf8d").update({
      "profile_field_group_id": "481d9228-c5a4-460b-93a4-5442b505a749",
      "name": "steam",
      "label": "Steam",
      "created_at": "2020-11-17 16:27:50 UTC",
      "updated_at": "2020-11-17 16:27:50 UTC",
      "uuid": "56a39e65-df40-4a58-8fdb-1a117fb6cf8d",
      "pattern": "https://steamcommunity.com/id/username",
      "regexp": "steamcommunity\\.com\\/id\\/([\\w|\\-|\\_|\\&]*)",
      "validation": "^[a-z0-9A-Z_\\.-]+$",
      "deep_link_pattern": "",
      "app_store_id": "",
      "play_store_id": "",
      "description": "",
      "restricted": false
    })
    ProfileField.find_or_create_by(uuid: "67cbaa22-5fd1-41ca-bc30-90581a39b5b8").update({
      "profile_field_group_id": "33d413b2-1df6-4852-8dce-2d7f10d7e1d0",
      "name": "telegram",
      "label": "Telegram",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2021-07-25 16:23:34 UTC",
      "uuid": "67cbaa22-5fd1-41ca-bc30-90581a39b5b8",
      "pattern": "https://t.me/username",
      "regexp": "t\\.me\\/([\\w|\\-|\\_|\\&]*)",
      "validation": "^[a-z0-9A-Z_]+$",
      "deep_link_pattern": "tg://resolve?domain=value",
      "app_store_id": "686449807",
      "play_store_id": "org.telegram.messenger",
      "description": "The first thing to send on the Howlr chat.",
      "restricted": true
    })
    ProfileField.find_or_create_by(uuid: "9169ee6c-88fd-49f1-8585-290c59562f7d").update({
      "profile_field_group_id": "26b8cddc-1431-4de4-8212-15f8cee7268f",
      "name": "twitter_ad",
      "label": "Twitter AD",
      "created_at": "2020-11-17 16:23:08 UTC",
      "updated_at": "2020-11-21 22:18:16 UTC",
      "uuid": "9169ee6c-88fd-49f1-8585-290c59562f7d",
      "pattern": "https://twitter.com/username",
      "regexp": "twitter\\.com\\/([\\w|\\-|\\_|\\&]*)",
      "validation": "^[a-z0-9A-Z_\\.-]+$",
      "deep_link_pattern": "",
      "app_store_id": "",
      "play_store_id": "",
      "description": "",
      "restricted": false
    })
    ProfileField.find_or_create_by(uuid: "93446912-cd2b-44df-b5ed-8ac060316092").update({
      "profile_field_group_id": "9123ae15-dc21-42c9-8fcd-cd8a1473d514",
      "name": "sofurry",
      "label": "Sofurry",
      "created_at": "2019-03-03 09:32:13 UTC",
      "updated_at": "2020-11-17 14:57:00 UTC",
      "uuid": "93446912-cd2b-44df-b5ed-8ac060316092",
      "pattern": "https://username.sofurry.com",
      "regexp": "https:\\/\\/(.+)\\.sofurry.com",
      "validation": "^[a-z0-9A-Z_\\.-~-]+$",
      "deep_link_pattern": "",
      "app_store_id": "",
      "play_store_id": "",
      "description": "Bring back the cum counter!",
      "restricted": false
    })
    ProfileField.find_or_create_by(uuid: "a1cf2dce-2e83-4431-8783-4e68d080714e").update({
      "profile_field_group_id": "9123ae15-dc21-42c9-8fcd-cd8a1473d514",
      "name": "inkbunny",
      "label": "Inkbunny",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2020-11-17 14:57:00 UTC",
      "uuid": "a1cf2dce-2e83-4431-8783-4e68d080714e",
      "pattern": "https://inkbunny.net/username",
      "regexp": "/inkbunny\\.net\\/([\\w|\\-|\\_|\\&]*)",
      "validation": "^[a-z0-9A-Z_\\.-]+$",
      "deep_link_pattern": "",
      "app_store_id": "",
      "play_store_id": "",
      "description": "",
      "restricted": false
    })
    ProfileField.find_or_create_by(uuid: "b47dc65d-a945-4f0b-8fae-804ea1c0fdc3").update({
      "profile_field_group_id": "8e55e087-8472-489f-bdd6-8a947573adbb",
      "name": "my_website",
      "label": "My website",
      "created_at": "2018-06-18 08:03:48 UTC",
      "updated_at": "2020-11-21 22:17:15 UTC",
      "uuid": "b47dc65d-a945-4f0b-8fae-804ea1c0fdc3",
      "pattern": "https://url",
      "regexp": "https://(.*)",
      "validation": "[-a-zA-Z0-9@:%._\\+~#=]{2,256}\\.[a-z]{2,6}\\b([-a-zA-Z0-9@:%_\\+.~#?&//=]*)",
      "deep_link_pattern": "",
      "app_store_id": "",
      "play_store_id": "",
      "description": "Oh! You have a website too?",
      "restricted": false
    })
    ProfileField.find_or_create_by(uuid: "bbffce9f-c339-493d-a03d-2b7169958060").update({
      "profile_field_group_id": "9123ae15-dc21-42c9-8fcd-cd8a1473d514",
      "name": "flist",
      "label": "F-List",
      "created_at": "2020-11-17 15:37:38 UTC",
      "updated_at": "2020-11-21 20:42:23 UTC",
      "uuid": "bbffce9f-c339-493d-a03d-2b7169958060",
      "pattern": "https://www.f-list.net/c/username",
      "regexp": "f-list\\.net\\/c\\/([\\w|\\-|\\_|\\&]*)",
      "validation": "^[a-z0-9A-Z_\\.-]+$",
      "deep_link_pattern": "",
      "app_store_id": "",
      "play_store_id": "",
      "description": "The most comprehensive list of weird kinks around.",
      "restricted": false
    })
    ProfileField.find_or_create_by(uuid: "d0b9e6db-b25a-4042-824c-aca9e712bda1").update({
      "profile_field_group_id": "8dbdf963-a5d8-45e0-a595-0965d3ecb540",
      "name": "twitter",
      "label": "Twitter",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2020-11-17 15:19:10 UTC",
      "uuid": "d0b9e6db-b25a-4042-824c-aca9e712bda1",
      "pattern": "https://twitter.com/username",
      "regexp": "twitter\\.com\\/([\\w|\\-|\\_|\\&]*)",
      "validation": "^[a-z0-9A-Z_\\.-]+$",
      "deep_link_pattern": "",
      "app_store_id": "",
      "play_store_id": "",
      "description": "",
      "restricted": false
    })
    ProfileField.find_or_create_by(uuid: "da225878-eab7-4430-aa2c-eead1f888ab6").update({
      "profile_field_group_id": "9123ae15-dc21-42c9-8fcd-cd8a1473d514",
      "name": "furaffinity",
      "label": "Furaffinity",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2020-11-17 14:57:00 UTC",
      "uuid": "da225878-eab7-4430-aa2c-eead1f888ab6",
      "pattern": "http://furaffinity.net/user/username",
      "regexp": "furaffinity\\.net\\/user\\/([\\w|\\-|\\_|\\&]*)",
      "validation": "^[a-z0-9A-Z_\\.-~-]+$",
      "deep_link_pattern": "",
      "app_store_id": "",
      "play_store_id": "",
      "description": "If you think FA is too old, try VCL.",
      "restricted": false
    })
    RelationshipStatus.find_or_create_by(uuid: "1312892e-c335-40d9-b903-514acf4e8028").update({
      "order": 3,
      "name": "in_an_open_relationship",
      "label": "In an open relationship",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-16 15:19:42 UTC",
      "uuid": "1312892e-c335-40d9-b903-514acf4e8028"
    })
    RelationshipStatus.find_or_create_by(uuid: "25f60631-31b5-42c8-98e7-954098fa8c4d").update({
      "order": 2,
      "name": "in_a_relationship",
      "label": "In a relationship",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-16 15:19:42 UTC",
      "uuid": "25f60631-31b5-42c8-98e7-954098fa8c4d"
    })
    RelationshipStatus.find_or_create_by(uuid: "340642ef-2621-416e-a85f-fc8484c36af5").update({
      "order": 5,
      "name": "engaged_or_married",
      "label": "Engaged or married",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-16 15:19:42 UTC",
      "uuid": "340642ef-2621-416e-a85f-fc8484c36af5"
    })
    RelationshipStatus.find_or_create_by(uuid: "4d3f8572-f2c0-4b09-8710-7d60e75a7a80").update({
      "order": 6,
      "name": "in_a_domestic_partnership",
      "label": "In a domestic partnership",
      "created_at": "2018-09-12 20:45:09 UTC",
      "updated_at": "2018-09-12 20:45:53 UTC",
      "uuid": "4d3f8572-f2c0-4b09-8710-7d60e75a7a80"
    })
    RelationshipStatus.find_or_create_by(uuid: "9f60abef-5362-4da1-a466-be5f0888162f").update({
      "order": 7,
      "name": "Other",
      "label": "Other",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-09-12 20:43:59 UTC",
      "uuid": "9f60abef-5362-4da1-a466-be5f0888162f"
    })
    RelationshipStatus.find_or_create_by(uuid: "a76d0d61-e49a-4667-845a-8cfb6e8cefcd").update({
      "order": 0,
      "name": "single_looking",
      "label": "Single and looking",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-16 15:19:42 UTC",
      "uuid": "a76d0d61-e49a-4667-845a-8cfb6e8cefcd"
    })
    RelationshipStatus.find_or_create_by(uuid: "ac35b6fd-5d37-4fdb-83c3-d02e8149ffd9").update({
      "order": 4,
      "name": "in_a_polyamorous_relationship",
      "label": "In a polyamorous relationship",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-16 15:19:42 UTC",
      "uuid": "ac35b6fd-5d37-4fdb-83c3-d02e8149ffd9"
    })
    RelationshipStatus.find_or_create_by(uuid: "e9499fdb-c233-4cf3-b4c0-6ea00fddbfc0").update({
      "order": 1,
      "name": "single_not_looking",
      "label": "Single and not looking",
      "created_at": "2018-05-16 15:19:42 UTC",
      "updated_at": "2018-05-16 15:19:42 UTC",
      "uuid": "e9499fdb-c233-4cf3-b4c0-6ea00fddbfc0"
    })
    SexualOrientation.find_or_create_by(uuid: "07d3b219-6318-432b-ae5f-d467dbf51235").update({
      "uuid": "07d3b219-6318-432b-ae5f-d467dbf51235",
      "name": "queer",
      "label": "Queer",
      "order": 10,
      "created_at": "2018-06-20 11:15:44 UTC",
      "updated_at": "2018-06-20 11:15:44 UTC"
    })
    SexualOrientation.find_or_create_by(uuid: "0a3e9b3d-dea4-40c0-af4a-b51e6b1f3e0f").update({
      "uuid": "0a3e9b3d-dea4-40c0-af4a-b51e6b1f3e0f",
      "name": "heteroflexible",
      "label": "Heteroflexible",
      "order": 7,
      "created_at": "2018-06-20 11:15:44 UTC",
      "updated_at": "2018-06-20 11:15:44 UTC"
    })
    SexualOrientation.find_or_create_by(uuid: "145b3dbd-8d49-40c0-be5f-b657de34c1d3").update({
      "uuid": "145b3dbd-8d49-40c0-be5f-b657de34c1d3",
      "name": "other",
      "label": "Other",
      "order": 11,
      "created_at": "2020-11-02 12:26:28 UTC",
      "updated_at": "2020-11-02 12:26:28 UTC"
    })
    SexualOrientation.find_or_create_by(uuid: "2e1035f1-fadb-4c44-a790-c3166523be00").update({
      "uuid": "2e1035f1-fadb-4c44-a790-c3166523be00",
      "name": "questioning",
      "label": "Questioning",
      "order": 9,
      "created_at": "2018-06-20 11:15:44 UTC",
      "updated_at": "2018-06-20 11:15:44 UTC"
    })
    SexualOrientation.find_or_create_by(uuid: "35210ee7-1825-41de-b3f5-2539eaa93f87").update({
      "uuid": "35210ee7-1825-41de-b3f5-2539eaa93f87",
      "name": "bisexual",
      "label": "Bisexual",
      "order": 3,
      "created_at": "2018-06-20 11:15:44 UTC",
      "updated_at": "2018-06-20 11:15:44 UTC"
    })
    SexualOrientation.find_or_create_by(uuid: "4bfeae61-c26c-4ee3-89ba-8fe77040fc32").update({
      "uuid": "4bfeae61-c26c-4ee3-89ba-8fe77040fc32",
      "name": "demisexual",
      "label": "Demisexual",
      "order": 6,
      "created_at": "2018-06-20 11:15:44 UTC",
      "updated_at": "2018-06-20 11:15:44 UTC"
    })
    SexualOrientation.find_or_create_by(uuid: "5e1d2f6f-f157-4a41-9723-026ad3b73369").update({
      "uuid": "5e1d2f6f-f157-4a41-9723-026ad3b73369",
      "name": "straight",
      "label": "Straight",
      "order": 0,
      "created_at": "2018-06-20 11:15:44 UTC",
      "updated_at": "2018-06-20 11:15:44 UTC"
    })
    SexualOrientation.find_or_create_by(uuid: "5fd6483b-68b9-44a5-b8fb-9c06aa6f589a").update({
      "uuid": "5fd6483b-68b9-44a5-b8fb-9c06aa6f589a",
      "name": "pansexual",
      "label": "Pansexual",
      "order": 4,
      "created_at": "2018-06-20 11:15:44 UTC",
      "updated_at": "2018-06-20 11:15:44 UTC"
    })
    SexualOrientation.find_or_create_by(uuid: "614dbb1b-4e4a-4db6-bbb6-a6c494fa35b6").update({
      "uuid": "614dbb1b-4e4a-4db6-bbb6-a6c494fa35b6",
      "name": "lesbian",
      "label": "Lesbian",
      "order": 1,
      "created_at": "2018-06-20 11:15:44 UTC",
      "updated_at": "2018-06-20 11:15:44 UTC"
    })
    SexualOrientation.find_or_create_by(uuid: "ab0cab73-bc32-40dc-9b45-2f9a342d602e").update({
      "uuid": "ab0cab73-bc32-40dc-9b45-2f9a342d602e",
      "name": "homoflexible",
      "label": "Homoflexible",
      "order": 8,
      "created_at": "2018-06-20 11:15:44 UTC",
      "updated_at": "2018-06-20 11:15:44 UTC"
    })
    SexualOrientation.find_or_create_by(uuid: "eb07d254-9dca-4ce1-b933-f24e1311c68a").update({
      "uuid": "eb07d254-9dca-4ce1-b933-f24e1311c68a",
      "name": "gay",
      "label": "Gay",
      "order": 2,
      "created_at": "2018-06-20 11:15:44 UTC",
      "updated_at": "2018-06-20 11:15:44 UTC"
    })
    SexualOrientation.find_or_create_by(uuid: "f6e9a170-708b-481b-a414-a6be93b47ab8").update({
      "uuid": "f6e9a170-708b-481b-a414-a6be93b47ab8",
      "name": "asexual",
      "label": "Asexual",
      "order": 5,
      "created_at": "2018-06-20 11:15:44 UTC",
      "updated_at": "2018-06-20 11:15:44 UTC"
    })
    TosItem.find_or_create_by(id: "18").update({
      "uuid": "0447755e-fc0e-45c4-97bb-b9cf2da171e4",
      "type": "TosItem",
      "title": "",
      "body": "You must be 18 or older to use Howlr.",
      "order": 10,
      "created_at": "2020-11-21 11:00:55 UTC",
      "updated_at": "2020-11-21 11:00:55 UTC"
    })
    TosItem.find_or_create_by(id: "19").update({
      "uuid": "afed6c36-78a4-4c39-b653-98781057af02",
      "type": "TosItem",
      "title": "",
      "body": "You agree to use truthful information and not to impersonate anyone.",
      "order": 20,
      "created_at": "2020-11-21 11:00:55 UTC",
      "updated_at": "2020-11-21 11:00:55 UTC"
    })
    TosItem.find_or_create_by(id: "20").update({
      "uuid": "64097682-1d7e-43a9-9d97-19946d937144",
      "type": "TosItem",
      "title": "",
      "body": "You agree not to use any material, text, username, pictures or avatar that are forbidden under French law.",
      "order": 30,
      "created_at": "2020-11-21 11:00:55 UTC",
      "updated_at": "2020-11-21 11:00:55 UTC"
    })
    TosItem.find_or_create_by(id: "21").update({
      "uuid": "c3a85ec9-62f5-4f00-ab77-5d7a766be1e2",
      "type": "TosItem",
      "title": "",
      "body": "Events you create must have a lawful objective, take place in an authorized area, with the lawful and voluntary consent of every participant.\r\n",
      "order": 40,
      "created_at": "2020-11-21 11:00:55 UTC",
      "updated_at": "2020-11-21 11:00:55 UTC"
    })
    TosItem.find_or_create_by(id: "22").update({
      "uuid": "d564901f-3cbe-4ddf-9bf6-4addb5940ffc",
      "type": "TosItem",
      "title": "",
      "body": "Hate speech, harassment, threats, defamation are forbidden.",
      "order": 50,
      "created_at": "2020-11-21 11:00:55 UTC",
      "updated_at": "2020-11-21 11:00:55 UTC"
    })
    TosItem.find_or_create_by(id: "23").update({
      "uuid": "814ddb56-bc09-4f55-b0ef-7d8afead01b1",
      "type": "TosItem",
      "title": "",
      "body": "Offensive or pornographic materials are forbidden.",
      "order": 60,
      "created_at": "2020-11-21 11:00:55 UTC",
      "updated_at": "2020-11-21 11:00:55 UTC"
    })
    TosItem.find_or_create_by(id: "24").update({
      "uuid": "c00ed22a-002e-4615-964e-a49e7c3282ae",
      "type": "TosItem",
      "title": "",
      "body": "Unsolicited advertising is forbidden, advertising is allowed in your profile information as long as it is related to Furry material.",
      "order": 70,
      "created_at": "2020-11-21 11:00:55 UTC",
      "updated_at": "2020-11-21 11:00:55 UTC"
    })
    TosItem.find_or_create_by(id: "25").update({
      "uuid": "8d83ddcc-0bcb-41e1-b99f-3847f19281fe",
      "type": "TosItem",
      "title": "",
      "body": "Howlr reserves the right to refuse or suspend access to any user, for any reason or no reason, and without any notice.\r\n",
      "order": 80,
      "created_at": "2020-11-21 11:00:55 UTC",
      "updated_at": "2020-11-21 11:00:55 UTC"
    })
    PrivacyPolicyItem.find_or_create_by(id: "26").update({
      "uuid": "b9a26ab1-53b9-444d-816b-d6b969bca825",
      "type": "PrivacyPolicyItem",
      "title": "We only collect information for the purpose of providing our service, including:",
      "body": "* The personal informations from your profile.\r\n* The location you set in your profile. Please note that we never share your precise location (i.e. latitude and longitude) to other users.\r\n* Your Telegram ID and username, to authenticate you and communicate with you.\r\n* A unique device and session identifier to authenticate you and to send you notifications.\r\n* All the private information you share with other users (e.g., \"Likes\", chat messages, etc) so we can show them back to you and to your contacts.\r\n",
      "order": 10,
      "created_at": "2020-11-21 11:07:24 UTC",
      "updated_at": "2020-11-21 11:07:24 UTC"
    })
    PrivacyPolicyItem.find_or_create_by(id: "27").update({
      "uuid": "2daa6f73-f500-494f-841b-8432143ae8f2",
      "type": "PrivacyPolicyItem",
      "title": "",
      "body": "By uploading content on Howlr, you grant us permission to use and alter this content for the sole purpose of providing our service (e.g. to crop and resize images).\r\n",
      "order": 20,
      "created_at": "2020-11-21 11:07:24 UTC",
      "updated_at": "2020-11-21 11:07:24 UTC"
    })
    PrivacyPolicyItem.find_or_create_by(id: "28").update({
      "uuid": "7644c49e-d7dd-448a-99a2-17374b138071",
      "type": "PrivacyPolicyItem",
      "title": "",
      "body": "We do not share or sell your informations to third parties.\r\n",
      "order": 30,
      "created_at": "2020-11-21 11:07:24 UTC",
      "updated_at": "2020-11-21 11:07:24 UTC"
    })
    PrivacyPolicyItem.find_or_create_by(id: "29").update({
      "uuid": "6d1b6cd5-160f-49be-96d1-2af2396fee07",
      "type": "PrivacyPolicyItem",
      "title": "",
      "body": "Please note that Howlr does not yet support end-to-end encryption of private messages, however all your communications with our servers are encrypted. Messages are also encrypted before storage and only decrypted on demand.\r\n",
      "order": 40,
      "created_at": "2020-11-21 11:07:24 UTC",
      "updated_at": "2020-11-21 11:07:24 UTC"
    })
    PrivacyPolicyItem.find_or_create_by(id: "30").update({
      "uuid": "9d16cd04-d7c1-4978-912b-32327c835ccf",
      "type": "PrivacyPolicyItem",
      "title": "",
      "body": "When you delete your account, all your information, including session information, private messages, etc, are deleted immediately from our active database; encrypted backups and archives that may contains information you updated or deleted may be retained for up to 7 days.\r\n",
      "order": 50,
      "created_at": "2020-11-21 11:07:24 UTC",
      "updated_at": "2020-11-21 11:07:24 UTC"
    })
  end
end
