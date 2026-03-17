import com.dihaozhe.rtmsbackend.util.BaiduMapUtil;

public class TestDistance {
    public static void main(String[] args) {
        // Test distance calculation
        String storeAddress = "闽南师范大学东门"; // Store address
        String pickupAddress = "闽南师范大学西门"; // Pickup address
        String city = "漳州"; // City
        
        System.out.println("Test distance calculation - Store address: " + storeAddress + ", Pickup address: " + pickupAddress + ", City: " + city);
        
        // Calculate distance
        long distance = BaiduMapUtil.calculateDistance(storeAddress, pickupAddress, city);
        
        System.out.println("Distance calculation result: " + distance + " meters");
        
        // Check if distance meets requirements
        if (distance > 0 && distance <= 10000) {
            System.out.println("Distance meets requirements, can create order");
        } else if (distance == -1) {
            System.out.println("Address parsing or distance calculation failed");
        } else {
            System.out.println("Distance exceeds 10000 meters, cannot create order");
        }
    }
}