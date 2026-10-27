package Utils;

import com.github.javafaker.Faker;

import net.minidev.json.JSONObject;

public class DataGenerator {
      public static String getEmailRandom(){
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0,100) + "@test.com";
        return email;
    }

    public static String getRandomUsername(){
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;

    }

      public static String getRandonName(){
        Faker faker = new Faker();
        String name = faker.name().firstName() + " " + faker.name().lastName();
        return name;

    }

      public static JSONObject getUserRandom(){
        Faker faker = new Faker();
        String name = faker.name().firstName() + " " + faker.name().lastName();
        String gender = "male";
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0,100) + "67" + "@test.com";
        String status = "active";
        JSONObject json = new JSONObject();
        json.put("name", name);
        json.put("gender", gender);
        json.put("email", email);
        json.put("status", status);
        return json;
    }

    public static String getRandomTitle() {
        Faker faker = new Faker();
        return faker.lorem().sentence(5);
    }

    public static String getRandomBody() {
        Faker faker = new Faker();
        return faker.lorem().paragraph();
    }

    public static JSONObject getPostRandom() {
        Faker faker = new Faker();
        JSONObject json = new JSONObject();
        json.put("title", faker.lorem().sentence(4));
        json.put("body", faker.lorem().paragraph());
        return json;
    }

    public static JSONObject getPostRandom(int userId) {
        Faker faker = new Faker();
        JSONObject json = new JSONObject();
        json.put("user_id", userId);
        json.put("title", faker.lorem().sentence(4));
        json.put("body", faker.lorem().paragraph());
        return json;
    }

    public static JSONObject getCommentRandom() {
        Faker faker = new Faker();
        JSONObject json = new JSONObject();
        json.put("name", faker.name().fullName());
        json.put("email", faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@test.com");
        json.put("body", faker.lorem().sentence(6));
        return json;
    }

    public static JSONObject getCommentRandom(int postId) {
        Faker faker = new Faker();
        JSONObject json = new JSONObject();
        json.put("post_id", postId);
        json.put("name", faker.name().fullName());
        json.put("email", faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@test.com");
        json.put("body", faker.lorem().sentence(6));
        return json;
    }

    public static String getRandomCommentName() {
        Faker faker = new Faker();
        return faker.name().fullName();
    }

    public static String getRandomCommentEmail() {
        Faker faker = new Faker();
        return faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 1000) + "@test.com";
    }

    public static String getRandomCommentBody() {
        Faker faker = new Faker();
        return faker.lorem().sentence(8);
    }
}

