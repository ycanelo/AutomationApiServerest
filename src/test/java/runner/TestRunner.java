package runner;

import com.intuit.karate.junit5.Karate;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

public class TestRunner {

    @Test
    void runAllFeaturesIndividually() {
        String[] features = {
                "classpath:features/get-users.feature",
                "classpath:features/get-user-by-id.feature",
                "classpath:features/create-user.feature",
                "classpath:features/delete-user.feature",
                "classpath:features/put-user.feature"
        };

        for (String featurePath : features) {
            String featureName = featurePath.substring(featurePath.lastIndexOf("/") + 1).replace(".feature", "");
            String reportDir = "target/karate-reports/" + featureName;

            Results results = Runner.path(featurePath)
                    .outputCucumberJson(true)
                    .reportDir(reportDir)
                    .parallel(1);

            System.out.println("Ejecutado: " + featureName + " | Total: " + results.getScenariosTotal() +
                    ", Fallidos: " + results.getScenariosFailed());
        }
    }

    @Karate.Test
    Karate test_get_users() {
        return Karate.run("classpath:features/get-users.feature").relativeTo(getClass());
    }

    @Karate.Test
    Karate test_get_user_by_id() {
        return Karate.run("classpath:features/get-user-by-id.feature").relativeTo(getClass());
    }

    @Karate.Test
    Karate test_post_create_user() {
        return Karate.run("classpath:features/create-user.feature").relativeTo(getClass());
    }

    @Karate.Test
    Karate test_delete_user() {
        return Karate.run("classpath:features/delete-user.feature").relativeTo(getClass());
    }

    @Karate.Test
    Karate test_put_user() {
        return Karate.run("classpath:features/put-user.feature").relativeTo(getClass());
    }

}
